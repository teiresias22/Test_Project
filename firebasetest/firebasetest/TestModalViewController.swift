//
//  TestModalViewController.swift
//  firebasetest
//
//  Created by markcloud on 2022/11/04.
//

import UIKit

class TestModalViewController: UIViewController {

    @IBOutlet weak var profile: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()

        profile.layer.cornerRadius = 75
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
