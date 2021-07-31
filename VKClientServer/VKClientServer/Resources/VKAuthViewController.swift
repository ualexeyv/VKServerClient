//
//  VKAuthViewController.swift
//  VKClientServer
//
//  Created by пользовтель on 09.07.2021.
//

import UIKit
import WebKit
import SwiftKeychainWrapper

class VKAuthViewController: UIViewController {

    
    @IBOutlet weak var webView: WKWebView! {
        didSet {
            webView.navigationDelegate = self
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        if let ApiToken = KeychainWrapper.standard.string(forKey: "access_token"),
           let userId = KeychainWrapper.standard.string(forKey: "user_id") {
            Session.shared.token = ApiToken
            Session.shared.userId = userId
            showNewsScreen()
        }
        confAuth()
        // Do any additional setup after loading the view.
    }
    private func confAuth () {
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "oauth.vk.com"
        urlComponents.path = "/authorize"
        urlComponents.queryItems = [
            URLQueryItem(name: "client_id", value: "7831620"),
            URLQueryItem(name: "display", value: "mobile"),
            URLQueryItem(name: "redirect_uri", value: "https://oauth.vk.com/blank.html"),
            URLQueryItem(name: "scope", value: "262150"),
            URLQueryItem(name: "response_type", value: "token"),
            URLQueryItem(name: "revoke", value: "1"),
            URLQueryItem(name: "v", value: "5.68")
        ]
        
        let request = URLRequest(url: urlComponents.url!)
        webView.load(request)
    }
}
extension VKAuthViewController: WKNavigationDelegate {
    func webView(_ webView: WKWebView, decidePolicyFor navigationResponse: WKNavigationResponse, decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void) {
        guard let url = navigationResponse.response.url, url.path == "/blank.html", let fragment = url.fragment else {
            decisionHandler(.allow)
            return
        }
        let params = fragment
            .components(separatedBy: "&")
            .map { $0.components(separatedBy: "=")}
            .reduce([String: String]()) { result, param in
                var dict = result
                let key = param[0]
                let value = param[1]
                dict[key] = value
                return dict
            }
        guard let ApiToken = params["access_token"], let userId = params["user_id"] else {return}
       
        KeychainWrapper.standard.set(ApiToken, forKey: "access_token")
        KeychainWrapper.standard.set(userId, forKey: "user_id")
        Session.shared.token = ApiToken
        Session.shared.userId = userId
        
        decisionHandler(.cancel)
        showNewsScreen()
    }
    func showNewsScreen() {
        performSegue(withIdentifier: "successScreen", sender: self)
    }
}
