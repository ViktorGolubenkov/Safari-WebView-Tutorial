//
//  WebViewController.swift
//  SafariAndWebViewTutorial
//
//  Created by Viktor Golubenkov on 20.01.2021.
//

import UIKit
import WebKit

class WebViewController: UIViewController {

    @IBOutlet weak var webView: WKWebView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        webView.navigationDelegate = self
        

        let request = URLRequest(url: URL(string: "https://docs.github.com/en/github/site-policy/github-privacy-statement")!)
        webView.load(request)
        
//        webView.allowsBackForwardNavigationGestures = true
//        webView.allowsLinkPreview = true
    }
    
    @IBAction func dismissWebView(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func goBackPressed(_ sender: UIButton) {
        self.webView.stopLoading()
        self.webView.goBack()
    }
    
    @IBAction func goForwardPressed(_ sender: UIButton) {
        self.webView.stopLoading()
        self.webView.goForward()
    }

}

extension WebViewController: WKNavigationDelegate {
    
//    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
//        print(#function)
//    }
//    func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {
//        print(#function)
//    }
//    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
//        print(#function)
//    }
//    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
//        print(error)
//    }
//    func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
//        print(error)
//    }
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        if let host = navigationAction.request.url?.host {
            if host.contains("docs.github.com") {
                decisionHandler(.allow)
                return
            }
        }
        decisionHandler(.cancel)
    }
//    func webView(_ webView: WKWebView, decidePolicyFor navigationResponse: WKNavigationResponse, decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void) {
//        decisionHandler(.allow)
//    }
    
}


