//
//  WebViewController.swift
//  FoodPin
//
//  Created by Fatimah Galhoum on 4/30/19.
//  Copyright © 2019 Fatimah Galhoum. All rights reserved.
//

import UIKit
import WebKit



class WebViewController: UIViewController {

    var webView:WKWebView!



    //**************************************************

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        if let url = URL(string: "http://www.appcoda.com/contact"){
            let request = URLRequest(url: url)
            webView.load(request)
        }
        
    }
    //**************************************************

    
    //**************************************************
    //To change view from view controller to web view
    override func loadView() {
         webView = WKWebView()
         view = webView
    }
    //**************************************************

    
    
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
