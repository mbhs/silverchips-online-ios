//
//  ViewController.swift
//  Silverchips Online
//
//  Created by Matthew on 4/4/20.
//  Copyright © 2020 Technaplex. All rights reserved.
//

import UIKit
import WebKit

class ContentViewController: UIViewController {
    var contentManager: ContentManager?
    @IBOutlet weak var webView: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        contentManager?.delegate = self
        contentManager?.loadContent()
    }
}

extension ContentViewController: ContentDelegate {
    func didFailWithError(error: Error) {
        print("content delegate error")
        dump(error)
    }
    
    func loadedContent(html: String) {
        
        webView.loadHTMLString(html, baseURL: K.siteURL)
    }
    
    func noContent() {
        print("There was no content")
    }
    
    
}

extension WKWebView {
    func load(_ urlString: String) {
        if let url = URL(string: urlString) {
            let request = URLRequest(url: url)
            load(request)
        }
    }
}
