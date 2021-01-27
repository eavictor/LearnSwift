//
//  ViewController.swift
//  HelloWKWebView
//
//  Created by eavictor on 2020/12/27.
//

import UIKit
import WebKit

class ViewController: UIViewController, WKNavigationDelegate {
    
//    override var prefersStatusBarHidden: Bool {
//        return true
//    }

    @IBOutlet weak var myWebView: WKWebView!
    
    @IBOutlet weak var myActivityIndicator: UIActivityIndicatorView!
    
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        myActivityIndicator.startAnimating()
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        myActivityIndicator.stopAnimating()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        myWebView.navigationDelegate = self
        if let url:URL = URL(string: "https://24h.pchome.com.tw/") {
            let request:URLRequest = URLRequest(url: url)
            myWebView.load(request)
        }
        
    }


}

