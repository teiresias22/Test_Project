//
//  ViewController.swift
//  FCM_Test
//
//  Created by Joonhwan Jeon on 2022/07/06.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let test = UILabel()
        view.backgroundColor = .white
        view.addSubview(test)
        test.text = "text"
        test.translatesAutoresizingMaskIntoConstraints = false
        test.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        test.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
    }
}

