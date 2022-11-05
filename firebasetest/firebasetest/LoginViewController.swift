//
//  LoginViewController.swift
//  firebasetest
//
//  Created by markcloud on 2022/11/01.
//

import UIKit
import Firebase

class LoginViewController: UIViewController {
    @IBOutlet weak var lblID: UILabel!
    @IBOutlet weak var lblPW: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        lblID.text = "로그인 성공 아이디 보여줄곳"
        lblPW.text = "로그인 성공 패스워드 보여줄곳"
        
        loadData()
    }
}
// MARK: - Func
extension LoginViewController {
    private func loadData() {
        let testItemsReference = Database.database().reference(withPath: "test-items")
        
        testItemsReference.child("user").getData { [self] error, snapshot in
            guard let snap = snapshot?.value else { return }
            print("\(#function) snap ===> \(snap)")
            
            let value = snapshot?.value as? NSDictionary
            lblID.text = value?["id"] as? String ?? "unknown"
            lblPW.text = value?["pw"] as? String ?? "unknown"
        }
    }
}

// MARK: - Event
extension LoginViewController {
    @IBAction func backButtonClicked(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
    
    @IBAction func imageButtonClicked(_ sender: UIButton) {
        let sb = UIStoryboard(name: "ImageUpload", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "ImageUploadViewController") as! ImageUploadViewController
        vc.modalTransitionStyle = .coverVertical
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true)
    }
}
