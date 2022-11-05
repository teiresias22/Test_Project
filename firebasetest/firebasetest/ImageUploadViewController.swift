//
//  ImageUploadViewController.swift
//  firebasetest
//
//  Created by markcloud on 2022/11/01.
//

import UIKit
import PhotosUI

import Firebase
import FirebaseStorage

class ImageUploadViewController: UIViewController {
    let storage = Storage.storage()
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var uploadButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
}

extension ImageUploadViewController {
    private func activeButton() {
        if imageView.image == nil {
            uploadButton.isEnabled = false
        } else {
            uploadButton.isEnabled = true
        }
    }
}

// MARK: - Action
extension ImageUploadViewController {
    @IBAction func selectImageButtonClicked(_ sender: UIButton) {
        PHPhotoLibrary.requestAuthorization(for: .readWrite) { status in
            switch status {
            case .authorized:
                DispatchQueue.main.async {
                    var configuration = PHPickerConfiguration()
                    configuration.filter = .any(of: [.images, .livePhotos])
                    
                    let picker = PHPickerViewController(configuration: configuration)
                    picker.delegate = self
                    self.present(picker, animated: true, completion: nil)
                }
            default:
                if let url = URL(string: UIApplication.openSettingsURLString) {
                    DispatchQueue.main.async {
                        UIApplication.shared.open(url, options: [:], completionHandler: nil)
                    }
                }
            }
        }
    }
    
    @IBAction func uploadButtonClicked(_ sender: UIButton) {
        uploadingImage(image: self.imageView.image!)
    }
    
    @IBAction func nextButtonClicked(_ sender: UIButton) {
        let sb = UIStoryboard(name: "Image", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "ImageViewController") as! ImageViewController
        vc.modalTransitionStyle = .coverVertical
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true)
    }
}

// MARK: - Func
extension ImageUploadViewController {
    private func uploadingImage(image: UIImage) {
        var data = Data()
        data = image.jpegData(compressionQuality: 0.8)!
        let filePath = "testImage"
        let metaData = StorageMetadata()
        metaData.contentType = "image/jpeg"
        
        storage.reference().child(filePath).putData(data, metadata: metaData){ metaData, error in
            if let error = error {
                print(error.localizedDescription)
                return
            } else {
                print("성공")
            }
        }
    }
}

extension ImageUploadViewController: PHPickerViewControllerDelegate {
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        picker.dismiss(animated: true)
        
        let itemProvider = results.first?.itemProvider
        if let itemProvider = itemProvider,
           itemProvider.canLoadObject(ofClass: UIImage.self) {
            itemProvider.loadObject(ofClass: UIImage.self) { (image, error) in
                DispatchQueue.main.async {
                    self.imageView.image = image as? UIImage
                }
            }
        } else {
            // TODO: Handle empty results or item provider not being able load UIImage
        }
    }
}
