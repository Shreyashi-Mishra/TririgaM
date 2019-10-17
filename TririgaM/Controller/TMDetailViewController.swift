//
//  DetailViewController.swift
//  Attachments
//
//  Created by Sharvari H V on 10/9/19.
//  Copyright © 2019 Sharvari H V. All rights reserved.
//

import UIKit
import WebKit



class TMDetailViewController: UIViewController {

    var filePath : URL?
    
    @IBOutlet weak var webView: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let url = filePath else {
            return
        }
       
        webView.uiDelegate = self
        webView.navigationDelegate = self
        webView.loadFileURL(url, allowingReadAccessTo: url)
        // Do any additional setup after loading the view.
    }
}

extension TMDetailViewController : WKUIDelegate, WKNavigationDelegate {
    
}
