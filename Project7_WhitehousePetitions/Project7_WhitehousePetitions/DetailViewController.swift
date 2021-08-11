//
//  DetailViewController.swift
//  Project7_WhitehousePetitions
//
//  Created by Effrafax Bulwer on 8/4/21.
//  Copyright © 2021 Effrafax Bulwer. All rights reserved.
//

import UIKit
import WebKit

class DetailViewController: UIViewController {
    
    var webView: WKWebView!
    var detailItem: Petition?
    
    override func loadView() {
        webView = WKWebView()
        view = webView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let detailItem = detailItem else { return }
        
        // html код, где размер шрифта будет составлять 150% от стандартного и объединен с body нашей петиции
        let html = """
        <html>
        <head>
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <style> body { font-size: 150%; } </style>
        </head>
        <body>
        \(detailItem.body)
        </body>
        </html>
        """
        
        // Подгрузка HTML кода
        webView.loadHTMLString(html, baseURL: nil)
    }
}
