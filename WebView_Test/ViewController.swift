//
//  ViewController.swift
//  WebView_Test
//
//  Created by Joonhwan Jeon on 2022/07/07.
//

import UIKit
import WebKit

class ViewController: UIViewController {
    
    @IBOutlet weak var webView: WKWebView!
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var forwardBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        loadURL()
    }
    
    func loadURL() {
        let url = URL(string: "https://www.google.co.kr")
        let request = URLRequest(url: url!)
        
        webView.load(request)
        
        webView.uiDelegate = self
        webView.navigationDelegate = self
    }
    
    public override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        checkNetworkConnect()
    }
    
    func checkNetworkConnect() {
        if Reachability.isConnectedToNetwork() {
            print("Network Connect")
        } else {
            print("Network Not Connect")
            
            let networkCheckAlert = UIAlertController(title: "Network Error", message: "앱 종료", preferredStyle: UIAlertController.Style.alert)
            networkCheckAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (_: UIAlertAction) in
                print("App exit")
                exit(0)
            }))
            
            self.present(networkCheckAlert, animated: true, completion: nil)
        }
    }
    
    @IBAction func backBtnClicked(_ sender: UIButton) {
        if (webView.canGoBack) {
            webView.goBack()
        } else {
            print("no back page")
        }
    }
    
    @IBAction func forwardBtnClicked(_ sender: UIButton) {
        if (webView.canGoForward) {
            webView.goForward()
        } else {
            print("no forward page")
        }
    }
}

//프로토콜로 페이지의 start, loading, finish, error 트리거 이벤트 캐치하여 사용자 동작 구현
extension ViewController: WKNavigationDelegate {
    public func webViewWebContentProcessDidTerminate(_ webView: WKWebView) {
        webView.reload()
    }
}

//JavaScript 기타 플러그인 컨텐츠 이벤트 캐치하여 동작. 웹페이지 기본 사용자 인터페이스 요소 제공
extension ViewController: WKUIDelegate {
    
}
