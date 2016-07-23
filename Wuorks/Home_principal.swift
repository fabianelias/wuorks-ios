//
//  Home_principal.swift
//  Wuorks
//
//  Created by Fabian on 23-07-16.
//  Copyright © 2016 Fabian. All rights reserved.
//

import UIKit

class Home_principal: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var imgBackground: UIImageView!
    @IBOutlet weak var wuorksArea: UITextField!
    
    var gbf = Globals_functions()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Wuorks"
        
        CustomizeView()
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func CustomizeView(){
        
        self.view.backgroundColor = gbf.setUiColor(0xfbfbfb)//0x03a9f4
        
        self.wuorksArea.layer.cornerRadius = 5.0
        self.wuorksArea.clipsToBounds = true
    }
    
    /*********************************************************************
     * FUNCIONES PARA CONFIGURACIÓN DEL TECLADO EN EL FORMULARIO DE BUSQUEDA
     *********************************************************************/
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        
        self.wuorksArea.resignFirstResponder()
        
        return true
    }
    func textFieldDidEndEditing(textField: UITextField) {
        
        self.wuorksArea.resignFirstResponder()
    }
    /*********************************************************************
     * /FIN FUNCIONES DEL TECLADO
     *********************************************************************/
    
}
