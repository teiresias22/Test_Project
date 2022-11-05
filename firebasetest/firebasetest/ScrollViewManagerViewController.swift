//
//  ScrollViewManagerViewController.swift
//  firebasetest
//
//  Created by markcloud on 2022/11/04.
//

import UIKit

class ScrollViewManagerViewController : UIViewController {
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var backgroundView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
}

extension ScrollViewManagerViewController {
    func screenShotMethod() {
        let renderer = UIGraphicsImageRenderer(size: scrollView.contentSize)
        
        let image = renderer.image(actions: { context in
            backgroundView.layer.render(in: context.cgContext)
        })
        
        UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
    }
}

extension ScrollViewManagerViewController {
    @IBAction func screenShotClicked(_ sender: UIButton) {
        screenShotMethod()
    }
}
