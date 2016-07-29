//
//  Home_principal.swift
//  Wuorks
//
//  Created by Fabian on 23-07-16.
//  Copyright © 2016 Fabian. All rights reserved.
//

import UIKit
import Alamofire
import SVProgressHUD

class Home_principal: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var imgBackground: UIImageView!
    @IBOutlet weak var wuorksArea: UITextField!
    
    var gbf = Globals_functions()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        self.view.endEditing(true)
        
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        imageView.contentMode = .ScaleAspectFit
        
        let image = UIImage(named: "icono-Small")
        imageView.image = image
        navigationItem.titleView = imageView
        
        
        
        CustomizeView()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func CustomizeView(){
        
        self.view.backgroundColor = gbf.setUiColor(0xe9ebee)
        
        //Padding al buscador
        let paddingView = UIView(frame: CGRectMake(0, 0, 5, self.wuorksArea.frame.height))
        wuorksArea.leftView = paddingView
        wuorksArea.leftViewMode = UITextFieldViewMode.Always
        
        
        self.wuorksArea.layer.cornerRadius = 5.0
        self.wuorksArea.clipsToBounds = true
        let imageView = UIImageView();
        let image = UIImage(named: "Search-Small-40.png")!.alpha(0.5);
        imageView.image = image;
        self.wuorksArea.leftView = imageView;
        self.wuorksArea.leftViewMode = UITextFieldViewMode.Always
        imageView.frame = CGRectMake(5, 0, 15, 15)//CGRect(x:25, y: 50, width: 20, height: 20)
        self.wuorksArea.addSubview(imageView)
        
        
        let url_image = "https://static.teamtreehouse.com/assets/views/accounts/referrals/referrals-64e85dde817cb7b42da59b0656b7c455.svg"
        //https://www.wuorks.cl/asset_app/bg-1.jpg
        Alamofire.request(.GET, url_image).response { (request, response, data, error) in
            self.imgBackground.image = UIImage(data: data!, scale:1)
            self.imgBackground.backgroundColor = self.gbf.setUiColor(0xffffff)
            self.imgBackground.layer.borderColor = self.gbf.setUiColor(0xffffff).CGColor
        }
        
        //Elimina el borde en esta vista y todas sus subvistas
        for parent in self.navigationController!.navigationBar.subviews {
            for childView in parent.subviews {
                if(childView is UIImageView) {
                    childView.removeFromSuperview()
                }
            }
        }
        
        
        
        
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        self.wuorksArea.resignFirstResponder()
        performSegueWithIdentifier("showMapView", sender: nil)
        let backItem = UIBarButtonItem()
        backItem.title = ""
        navigationItem.backBarButtonItem = backItem
        return true
        /*
        if (self.wuorksArea.text == ""){
            let alertController = UIAlertController(title: "", message:
                "¿Qué profesional necesitas?", preferredStyle: UIAlertControllerStyle.Alert)
            alertController.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default,handler: nil))
            self.presentViewController(alertController, animated: true, completion: nil)
            return false
        }else{
            
            self.wuorksArea.resignFirstResponder()
            performSegueWithIdentifier("showMapView", sender: nil)
            let backItem = UIBarButtonItem()
            backItem.title = ""
            navigationItem.backBarButtonItem = backItem
            return true
        }*/
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "showMapView"
        {
            if let destinationVC = segue.destinationViewController as? MapView{
                
                destinationVC.wuorks_area = self.wuorksArea.text!
            }
        }
    }
    
    /*********************************************************************
     * FUNCIONES PARA CONFIGURACIÓN DEL TECLADO EN EL FORMULARIO DE BUSQUEDA
     *********************************************************************/
    
    func textFieldDidEndEditing(textField: UITextField) {
        
        self.wuorksArea.resignFirstResponder()
    }
    /*********************************************************************
     * /FIN FUNCIONES DEL TECLADO
     *********************************************************************/
    
}
