//
//  Home.swift
//  Wuorks
//
//  Created by Fabian on 22-07-16.
//  Copyright © 2016 Fabian. All rights reserved.
//

import UIKit
import Foundation
import Alamofire

class Home: UIViewController {
    
    @IBOutlet weak var logoutBtn: UIButton!
    @IBOutlet weak var scrollAjustes: UIScrollView!
    @IBOutlet weak var imgBackground: UIImageView!
    @IBOutlet weak var username: UILabel!
    @IBOutlet weak var nameUser: UILabel!
    @IBOutlet weak var avatarUser: UIImageView!
    
    var gbf = Globals_functions()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Ajustes"
        self.view.backgroundColor = gbf.setUiColor(0xfbfbfb)//0x03a9f4
        self.imgBackground.backgroundColor = self.gbf.setUiColor(0x607D8B)
        let prefs = NSUserDefaults.standardUserDefaults()
        
        
        if let username = prefs.stringForKey("username"){
            self.username.text = username
            self.username.textColor = self.gbf.setUiColor(0xCFD8DC)
        }
        
        if let name = prefs.stringForKey("name"){
            self.nameUser.text = name
            self.nameUser.textColor = self.gbf.setUiColor(0xCFD8DC)
        }
        
        if let avatar = prefs.stringForKey("avatar"){
            Alamofire.request(.GET, "https://www.wuorks.cl/asset/img/user_avatar/"+avatar).response { (request, response, data, error) in
                self.avatarUser.image = UIImage(data: data!, scale:1)
                self.avatarUser.backgroundColor = self.gbf.setUiColor(0xffffff)
                self.avatarUser.layer.cornerRadius = self.avatarUser.frame.size.width / 2
                self.avatarUser.clipsToBounds = true
                self.avatarUser.layer.borderWidth = 2.0
                self.avatarUser.layer.borderColor = self.gbf.setUiColor(0xffffff).CGColor
            }
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
