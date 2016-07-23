//
//  Globals_functions.swift
//  Wuorks
//
//  Created by Fabian on 22-07-16.
//  Copyright © 2016 Fabian. All rights reserved.
//

import UIKit
import Foundation

class Globals_functions{


    /*****************************************************************
    * @setUiColor(): FUNCIÓN PARA MANEJAR COLORES HEXADECIMALES.
    ******************************************************************/
    func setUiColor(rgbValue:UInt32) -> UIColor {
        let red   = CGFloat((rgbValue & 0xFF0000) >> 16) / 256.0
        let green = CGFloat((rgbValue & 0xFF00) >> 8) / 256.0
        let blue  = CGFloat(rgbValue  & 0xFF) / 256.0
        
        return  UIColor(red: red, green: green, blue: blue, alpha: 1.0)
    }
}
