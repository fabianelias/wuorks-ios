//
//  DetailUser.swift
//  Wuorks
//
//  Created by Fabian on 24-07-16.
//  Copyright © 2016 Fabian. All rights reserved.
//

import UIKit
import Alamofire
import SVProgressHUD

class DetailUser: UIViewController {
    
    var username = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //print(username)
        self.title = username
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
