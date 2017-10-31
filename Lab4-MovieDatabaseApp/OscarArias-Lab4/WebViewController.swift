//
//  WebViewController.swift
//  OscarArias-Lab4
//
//  Created by labuser on 10/24/17.
//  Copyright © 2017 labuser. All rights reserved.
//

import UIKit
import WebKit

class WebViewController: UIViewController, WKNavigationDelegate {
    var movieTitle: String!
    var webView: WKWebView!
    
    override func loadView() {
        webView = WKWebView()
        webView.navigationDelegate = self
        view = webView
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        print(movieTitle)
        let movieTitleParsed = movieTitle.replacingOccurrences(of: " ", with: "%20")
        let url = URL(string: "https://www.rottentomatoes.com/search/?search=\(movieTitleParsed)")!
        let myURLRequest = URLRequest(url: url)
        webView.load(myURLRequest)
        webView.allowsBackForwardNavigationGestures = true
        
    }
    
    func openPage(action: UIAlertAction!) {
        let url = URL(string: "https://" + action.title!)!
        
        
        webView.load(URLRequest(url: url))
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        title = webView.title
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    

}
