//
//  ViewController.swift
//  roadrunner
//
//  Created by TED on 2020/07/25.
//  Copyright © 2020 roadrunner. All rights reserved.
//

import UIKit
import WebKit

class MainViewController: UIViewController {

    @IBOutlet weak var webMain: WKWebView!
    var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
    @IBOutlet weak var viewBG: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        webMain.uiDelegate = self
        webMain.navigationDelegate = self
        
        let roadRunnerURL = "http://roadrunner-front.s3-website.ap-northeast-2.amazonaws.com"
        let url = URL(string: roadRunnerURL)
        let request = URLRequest(url: url!)
        webMain.load(request)
    }


}



extension MainViewController: WKUIDelegate, WKNavigationDelegate {
    
    @available(iOS 8.0, *)
    public func webView(_ webView: WKWebView, runJavaScriptAlertPanelWithMessage message: String, initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping () -> Swift.Void){
    let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
    let otherAction = UIAlertAction(title: "OK", style: .default, handler: {action in completionHandler()})
    alert.addAction(otherAction)

    self.present(alert, animated: true, completion: nil)
    }

    @available(iOS 8.0, *)
    public func webView(_ webView: WKWebView, runJavaScriptConfirmPanelWithMessage message: String, initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping (Bool) -> Swift.Void){
        let alert = UIAlertController(title: "", message: message, preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "CANCEL", style: .cancel, handler: {(action) in completionHandler(false)})
        let okAction = UIAlertAction(title: "OK", style: .default, handler: {(action) in completionHandler(true)})
        alert.addAction(cancelAction)
        alert.addAction(okAction)
        self.present(alert, animated: true, completion: nil)
    }


    @available(iOS 8.0, *)
    public func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!){
        if #available(iOS 13.0, *) {
            activityIndicator = UIActivityIndicatorView(style: .large)
        } else {
            activityIndicator = UIActivityIndicatorView()
        }
        activityIndicator.frame = CGRect(x: view.frame.midX-50, y: view.frame.midY-50, width: 100, height: 100)
        activityIndicator.color = UIColor.lightGray
        activityIndicator.hidesWhenStopped = true
        activityIndicator.startAnimating()
        self.view.addSubview(activityIndicator)
    }


    @available(iOS 8.0, *)
    public func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!){
        activityIndicator.stopAnimating()
        activityIndicator.removeFromSuperview()
        
        if viewBG != nil {
            UIView.animate(withDuration: 0.5, animations: {
                self.viewBG.alpha = 0
            }) { (finished) in
                self.viewBG.isHidden = true
                self.viewBG.removeFromSuperview()
            }
        }
    }
    
}
