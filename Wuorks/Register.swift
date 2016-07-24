//
//  Register.swift
//  Wuorks
//
//  Created by Fabian on 22-07-16.
//  Copyright © 2016 Fabian. All rights reserved.
//

import UIKit

class Register: UIViewController {
    
    var gbf = Globals_functions()
    
    @IBOutlet weak var registerView: UIWebView!
    @IBOutlet weak var returnBtn: UIButton!
    @IBOutlet weak var actLoad: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = gbf.setUiColor(0x2895F1)//0x03a9f4
        self.returnBtn.backgroundColor = gbf.setUiColor(0x2895F1)

        let url_register = NSURL(string: "https://www.wuorks.cl/oauth/register")
        
        registerView.loadRequest(NSURLRequest(URL: url_register!))
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func webViewDidStartLoad(_ : UIWebView){
        self.actLoad.startAnimating()
    }
    func webViewDidFinishLoad(_ : UIWebView){
        self.actLoad.stopAnimating()
    }

    
}
