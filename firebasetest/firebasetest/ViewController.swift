//
//  ViewController.swift
//  firebasetest
//
//  Created by markcloud on 2022/11/01.
//

import UIKit
import Firebase

class ViewController: UIViewController {
    @IBOutlet weak var inputID: UITextField!
    @IBOutlet weak var inputPW: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.inputID.placeholder = "이메일을 입력해 주세요"
        self.inputPW.placeholder = "비밀번호를 입력해 주세요"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.inputID.text = "test@email.com"
        self.inputPW.text = "000000"
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.inputID.text = nil
        self.inputPW.text = nil
    }
    
    @IBAction func halfModalButtonTapped(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "TestModal", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "TestModalViewController") as! TestModalViewController
        
        vc.modalPresentationStyle = .pageSheet
        
        if let sheet = vc.sheetPresentationController {
            
            //지원할 크기 지정
            sheet.detents = [.medium()]
            //크기 변하는거 감지
            sheet.delegate = self
           
            //시트 상단에 그래버 표시 (기본 값은 false)
            sheet.prefersGrabberVisible = false
            
            //처음 크기 지정 (기본 값은 가장 작은 크기)
            //sheet.selectedDetentIdentifier = .large
            
            //뒤 배경 흐리게 제거 (기본 값은 모든 크기에서 배경 흐리게 됨)
            //sheet.largestUndimmedDetentIdentifier = .medium
        }
        
        self.present(vc, animated: true)
    }
}

// MARK: - Event
extension ViewController {
    @IBAction func loginBTNClicked(_ sender: UIButton) {
        Auth.auth().signIn(withEmail: inputID.text!, password: inputPW.text!) { [self] authResult, error in
            if authResult != nil {
                let testItemsReference = Database.database().reference(withPath: "test-items")
                let userItemRef = testItemsReference.child("user")
                let values: [String: Any] = ["id": inputID.text!, "pw": inputPW.text!]
                userItemRef.setValue(values)
                
                self.nextPage()
            }
        }
    }
    
    @IBAction func signupBTNClicked(_ sender: UIButton) {
        Auth.auth().createUser(withEmail: inputID.text!, password: inputPW.text!) {
            authResult, error in
            print(authResult!)
        }
    }
    
    @IBAction func mapBTNClicked(_ sender: UIButton) {
        let sb = UIStoryboard(name: "Map", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "MapViewController") as! MapViewController
        
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    @IBAction func popupView(_ sender: UIButton) {
        let sb = UIStoryboard(name: "ScrollViewManager", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "ScrollViewManagerViewController") as! ScrollViewManagerViewController
        
        self.present(vc, animated: true)
    }
}

// MARK: - Func
extension ViewController {
    private func nextPage(){
        let sb = UIStoryboard(name: "Login", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
        vc.modalTransitionStyle = .coverVertical
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true)
    }
}

extension ViewController: UISheetPresentationControllerDelegate {
    func sheetPresentationControllerDidChangeSelectedDetentIdentifier(_ sheetPresentationController: UISheetPresentationController) {
        //크기 변경 됐을 경우
        print(sheetPresentationController.selectedDetentIdentifier == .large ? "large" : "medium")
    }
}
