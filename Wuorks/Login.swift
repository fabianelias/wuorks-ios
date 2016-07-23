//
//  Login.swift
//  Wuorks
//
//  Created by Fabian on 22-07-16.
//  Copyright © 2016 Fabian. All rights reserved.
//

import UIKit
import Foundation


class Login: UIViewController, UITextFieldDelegate {
    
    var gbf = Globals_functions()   //Libreria
    var login_model = Login_model() //Modelo
    
    
    @IBOutlet weak var titleView: UILabel!
    @IBOutlet weak var loginFacebook: UIButton!
    @IBOutlet weak var inputEmail: UITextField!
    @IBOutlet weak var inputPass: UITextField!
    @IBOutlet weak var loginBtn: UIButton!
    @IBOutlet weak var scrollLogin: UIScrollView!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        //CONFIGURACIÓN DE ELEMENTOS DE LA VISTA
        
        self.titleView.text = "Bienvenid@ a WUORKS"
        self.titleView.textColor = gbf.setUiColor(0xfbfbfb)
        
        self.view.backgroundColor = gbf.setUiColor(0x2895F1)//0x03a9f4
        self.loginFacebook.backgroundColor = gbf.setUiColor(0x03a9f4)
        self.loginBtn.backgroundColor = gbf.setUiColor(0x03a9f4)
        
        self.inputEmail.layer.cornerRadius = 5.0
        self.inputEmail.clipsToBounds = true
        self.inputPass.layer.cornerRadius = 5.0
        self.inputPass.clipsToBounds = true
        
        self.loginBtn.layer.cornerRadius = 5.0
        self.loginBtn.clipsToBounds = true
        
        self.loginFacebook.layer.cornerRadius = 9.0
        self.loginFacebook.clipsToBounds = true
        
    }
    
    //---------------------------------------------------------------------
    // @login(): FUNCIÓN QUE VALIDAD EL INGRESO DEL USUARIO MEDIANTE EMAIL
    // Y PASSWORD.
    //---------------------------------------------------------------------
    @IBAction func login(sender: AnyObject) {
        
        
        if self.inputEmail.text! == "" || self.inputPass.text! == ""{
            
            let alertController = UIAlertController(title: "Error", message:
                "Debes ingresar tu email y contraseña", preferredStyle: UIAlertControllerStyle.Alert)
            alertController.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default,handler: nil))
            
            self.presentViewController(alertController, animated: true, completion: nil)
            
        }else{
            
            let login = login_model.login(self.inputEmail.text!, password: self.inputPass.text!)
            
            if login == "1"{
                let alertController = UIAlertController(title: "Error", message:
                    "El email o contraseña no coincide", preferredStyle: UIAlertControllerStyle.Alert)
                alertController.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default,handler: nil))
                self.presentViewController(alertController, animated: true, completion: nil)
                
            }else if login == "2"{
                
                let alertController = UIAlertController(title: "Error", message:
                    "Necesitas validar tu cuenta de email", preferredStyle: UIAlertControllerStyle.Alert)
                alertController.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default,handler: nil))
                
                self.presentViewController(alertController, animated: true, completion: nil)
                
            }else{
                
                /*
                let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                let miVistaDos = storyBoard.instantiateViewControllerWithIdentifier("welcome") as! Welcome_index
                self.presentViewController(miVistaDos, animated:true, completion:nil)
                */
                
                self.performSegueWithIdentifier("loginSucess", sender: self);
                //self.dismissViewControllerAnimated(true, completion:nil);
                
            }
            
        }
        
    }
    
    /*********************************************************************
     * FUNCIONES PARA CONFIGURACIÓN DEL TECLADO EN EL FORMULARIO DE LOGIN
     * CON EMAIL.
     *********************************************************************/
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        if textField == self.inputEmail{
            inputPass.becomeFirstResponder()
        }else{
            inputPass.resignFirstResponder()
        }
        return true
    }
    
    func textFieldDidBeginEditing(textField: UITextField) {
        if textField == self.inputEmail{
            scrollLogin.setContentOffset(CGPointMake(0, 140), animated: true)
        }else{
            scrollLogin.setContentOffset(CGPointMake(0, 140), animated: true)
        }
    }
    
    func textFieldDidEndEditing(textField: UITextField) {
        
        if textField == self.inputEmail{
            self.inputPass.becomeFirstResponder()
            scrollLogin.setContentOffset(CGPointMake(0, 140), animated: true)
        }else{
            scrollLogin.setContentOffset(CGPointMake(0, 0), animated: true)
            inputPass.resignFirstResponder()
        }
    }
    /*********************************************************************
     * /FIN FUNCIONES DEL TECLADO
     *********************************************************************/
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
