//
//  ImageViewController.swift
//  firebasetest
//
//  Created by markcloud on 2022/11/01.
//

import UIKit
import FirebaseStorage
import Kingfisher

class ImageViewController: UIViewController {
    let storage = Storage.storage().reference()
    
    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        loadImage()
    }
}

//MARK: - Configure
extension ImageViewController {
    private func loadImage() {
        let starsRef = storage.child("testImage")
        
        starsRef.downloadURL { url, error in
            if let error = error {
                print(error.localizedDescription)
            } else {
                self.imageView.kf.setImage(with: url)
            }
        }
    }
}
