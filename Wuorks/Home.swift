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
        CustomizeView()
        
        let prefs = NSUserDefaults.standardUserDefaults()
        
        
        if let username = prefs.stringForKey("username"){
            self.username.text = username
            self.username.textColor = self.gbf.setUiColor(0x999999)
        }
        
        if let name = prefs.stringForKey("name"){
            self.nameUser.text = name
            self.nameUser.textColor = self.gbf.setUiColor(0x999999)
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
    
    func CustomizeView(){
        
        
        self.title = "Ajustes"
        self.view.backgroundColor = gbf.setUiColor(0xffffff)//0x03a9f4
        self.imgBackground.backgroundColor = self.gbf.setUiColor(0xfbfbfb)
        
        //Elimina el borde en esta vista y todas sus subvistas
        for parent in self.navigationController!.navigationBar.subviews {
            for childView in parent.subviews {
                if(childView is UIImageView) {
                    childView.removeFromSuperview()
                }
            }
        }
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    @IBAction func logout(sender: AnyObject) {
        
        NSUserDefaults.standardUserDefaults().setBool(false,forKey:"isUserLoggedIn");
        NSUserDefaults.standardUserDefaults().removePersistentDomainForName(NSBundle.mainBundle().bundleIdentifier!)
        NSUserDefaults.standardUserDefaults().synchronize();
        
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let miVistaDos = storyBoard.instantiateViewControllerWithIdentifier("welcome") as! Welcome_index
        self.presentViewController(miVistaDos, animated:true, completion:nil)
        
        
    }
    
}
