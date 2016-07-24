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
        self.title = "Wuorks"
        
        CustomizeView()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func CustomizeView(){
        
        self.view.backgroundColor = gbf.setUiColor(0xfbfbfb)
        
        self.wuorksArea.layer.cornerRadius = 5.0
        self.wuorksArea.clipsToBounds = true
        let imageView = UIImageView();
        let image = UIImage(named: "Search-Small-40.png")!.alpha(0.5);
        imageView.image = image;
        self.wuorksArea.leftView = imageView;
        self.wuorksArea.leftViewMode = UITextFieldViewMode.Always
        imageView.frame = CGRect(x:25, y: 50, width: 20, height: 20)
        self.wuorksArea.addSubview(imageView)
        
        
        
        Alamofire.request(.GET, "https://www.wuorks.cl/asset_app/bg-2.jpg").response { (request, response, data, error) in
            self.imgBackground.image = UIImage(data: data!, scale:1)
            self.imgBackground.backgroundColor = self.gbf.setUiColor(0xffffff)
            self.imgBackground.layer.borderColor = self.gbf.setUiColor(0xffffff).CGColor
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
