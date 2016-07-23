//
//  Login_model.swift
//  Wuorks
//
//  Created by Fabian on 22-07-16.
//  Copyright © 2016 Fabian. All rights reserved.
//

import Foundation
import Alamofire

class Login_model {
    
    var config = Config()
    
    //-----------------------------------------------------------
    // @login(): Función para login de la app.
    // recibe 2 parametros: email o username y contraseña.
    //
    //-----------------------------------------------------------
    
    func login(email_username: String!, password: String!)->String{
        
        let passMd5 = md5Pass(string:password)
        
        let parameters = [
            "email": email_username,
            "password": passMd5
        ]
        
        var resp:String! = ""
        
        Alamofire.request(.POST, config.url_api + "login/login/key/" + config.key_public, parameters:parameters).responseJSON { response in
            if let res = response.result.value{
                
                let array = res["res"] as! Int
               
                if array == 1{
                    resp = "1"
                }else if array == 2{
                    resp = "2"
                }else{
                    let data = res["data"] as! NSArray
                    let username = data[0]["username"] as! String
                    //let name     = data[0]["name"] as! String
                    //let lastname = data[0]["last_name"] as! String
                    let avatar   = data[0]["avatar"] as! String
                    
                    resp = "\(username)"
                    
                    let prefs = NSUserDefaults.standardUserDefaults()
                    prefs.setBool(true,forKey:"isUserLoggedIn");
                    
                    prefs.setValue("\(username)", forKey: "username")
                   // prefs.setValue("\(name) \(lastname)", forKey: "name")
                    prefs.setValue("\(avatar)", forKey: "avatar")
                    
                    prefs.synchronize()
                    
                                     
                }
            }
        }
        return resp
    }
    
    //-----------------------------------------------------------
    // @md5Pass(): Función para convertir la password en formato md5 para enviarla por
    // https al API
    //-----------------------------------------------------------
    
    func md5Pass(string string: String) -> String {
        
        var digest = [UInt8](count: Int(CC_MD5_DIGEST_LENGTH), repeatedValue: 0)
        if let data = string.dataUsingEncoding(NSUTF8StringEncoding) {
            CC_MD5(data.bytes, CC_LONG(data.length), &digest)
        }
        
        var digestHex = ""
        for index in 0..<Int(CC_MD5_DIGEST_LENGTH) {
            digestHex += String(format: "%02x", digest[index])
        }
        
        return digestHex
    }
    
}