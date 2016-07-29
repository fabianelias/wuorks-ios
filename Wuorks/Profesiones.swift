//
//  Profesiones.swift
//  Wuorks
//
//  Created by Fabian on 24-07-16.
//  Copyright © 2016 Fabian. All rights reserved.
//

import UIKit
import Alamofire
import SVProgressHUD

class Profesiones: UIViewController {
    
    var gbf = Globals_functions()
    var config = Config()
    
    @IBOutlet weak var scrollProfes: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = gbf.setUiColor(0xe9ebee)
        
        scrollProfes.contentSize.height = 1500
        getProfessions()
        
        
        
        //Elimina el borde en esta vista y todas sus subvistas
        for parent in self.navigationController!.navigationBar.subviews {
            for childView in parent.subviews {
                if(childView is UIImageView) {
                    childView.removeFromSuperview()
                }
            }
        }
        
    }
    
    func getProfessions(){
        
        
        let prefs = NSUserDefaults.standardUserDefaults()
        let id_user = prefs.stringForKey("id_user")
        let url = config.url_api+"profession/professions/id_user/"+id_user!+"/key/"+config.key_public
        
        //print(url)
        
        Alamofire.request(.GET, url).responseJSON { response in
            if let Res = response.result.value{
                if(Res as! NSObject == 1){
                    //print("No tiene profesiones")
                }else{
                    //print("Si tiene profesiones")
                }
               // let wuoker = Res as! NSArray
                //print(Res)
            }
        }

        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
