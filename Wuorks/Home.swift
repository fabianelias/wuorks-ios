//
//  Home.swift
//  Wuorks
//
//  Created by Fabian on 22-07-16.
//  Copyright © 2016 Fabian. All rights reserved.
//

import UIKit
import Foundation

class Home: UIViewController {
    
    @IBOutlet weak var logoutBtn: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let prefs = NSUserDefaults.standardUserDefaults()
        
        
        if let username = prefs.stringForKey("username"){
            self.title = "Hola" + username
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    @IBAction func logout(sender: AnyObject) {
        
        NSUserDefaults.standardUserDefaults().setBool(false,forKey:"isUserLoggedIn");
        NSUserDefaults.standardUserDefaults().synchronize();
        
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let miVistaDos = storyBoard.instantiateViewControllerWithIdentifier("welcome") as! Welcome_index
        self.presentViewController(miVistaDos, animated:true, completion:nil)
        
        //self.performSegueWithIdentifier("userConnect", sender: self);
        
    }
    /*
    override func viewDidAppear(animated: Bool)
    {
        NSUserDefaults.standardUserDefaults().synchronize();
        let isUserLoggedIn = NSUserDefaults.standardUserDefaults().boolForKey("isUserLoggedIn");
        
        if(!isUserLoggedIn)
        {
            self.performSegueWithIdentifier("userConnect", sender: self);
        }
        
        
    }*/
    
    
}
