//
//  RecepieDetailViewController.swift
//  InstantRecepie
//
//  Created by MAC on 18/06/20.
//  Copyright © 2020 Techangouts. All rights reserved.
//

import UIKit
import WebKit

class RecepieDetailViewController: UIViewController {
    
    
    //MARK:- Outlets
    @IBOutlet weak var webview: WKWebView!
    
    //MARK:- Variables
    var urlString : String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        webview.load(URLRequest(url: URL(string: urlString ?? "")!))
        
    }
    
    //MARK:- Action
    @IBAction func backBtn(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
}
