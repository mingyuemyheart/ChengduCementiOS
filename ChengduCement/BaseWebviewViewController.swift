//
//  BaseWebviewViewController.swift
//  ChengduCement
//
//  Created by 孙晓明 on 2020/8/14.
//  Copyright © 2020 孙晓明. All rights reserved.
//

import UIKit
import WebKit

class BaseWebviewViewController: BaseViewController, WKNavigationDelegate, WKUIDelegate, WKScriptMessageHandler {
    
    var webView:WKWebView?

    override func viewDidLoad() {
        super.viewDidLoad()

        //webView
        loadWebView(url: CONST.init().HTMLURL)
        self.view.addSubview(webView!)
    }
    
    func loadWebView(url: String) {
        print(url)
        dialog.showDialog()
        let conf = WKWebViewConfiguration()
        conf.userContentController = WKUserContentController()
        conf.preferences.javaScriptEnabled = true
        //注册需要监听的js方法名
        conf.userContentController.add(self, name: "tokenLost")
        
        if webView == nil {
            webView = WKWebView(frame: CGRect(x: 0, y: 0, width: screenW, height: screenH), configuration: conf)
        }
        let url = URL(string: url)
        let request = URLRequest(url: url!)
        webView!.load(request)
//        webView?.loadFileURL(Bundle.main.url(forResource: "test", withExtension: "html")!, allowingReadAccessTo: Bundle.main.bundleURL)
        webView!.uiDelegate = self
        webView!.navigationDelegate = self
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        dialog.hideDialog()
        self.webView?.evaluateJavaScript("getToken('\(UserUtil.init().getToken())')", completionHandler: { (dic, error) in
            print("getToken('\(UserUtil.init().getToken())')")
        })
    }
    
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        dialog.hideDialog()
    }

    /**
     继承WKScriptMessageHandler 并重写userContentController方法,在该方法里接收JS传来的参数
     */
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        switch message.name {
            case "tokenLost":
                print(message.body)
                self.navigationController?.popToRootViewController(animated: true)
            default: break
        }
    }
    
//    func loadWebView(url: String) {
//        print(url)
//        dialog.showDialog()
//        if webView == nil {
//            webView = UIWebView(frame: CGRect(x: 0, y: 0, width: screenW, height: screenH))
//        }
//        let url = URL(string: url)
//        let request = URLRequest(url: url!)
//        webView?.loadRequest(request)
//        webView!.delegate = self
//        
//        self.webView?.stringByEvaluatingJavaScript(from: "\(UserUtil.init().getToken())")
//    }
//    
//    func webViewDidFinishLoad(_ webView: UIWebView) {
//        dialog.hideDialog()
//        
//        self.webView?.stringByEvaluatingJavaScript(from: "\(UserUtil.init().getToken())")
//    }
//    
//    func webView(_ webView: UIWebView, didFailLoadWithError error: Error) {
//        dialog.hideDialog()
//    }

}
