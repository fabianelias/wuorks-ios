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
    
    /*****************************************************************
     * @setTitle(): FUNCIÓN PARA MANEJAR SUBTITULOS EN NAVEGATION
     * CONTROLLER
     ******************************************************************/
    func setTitle(title:String, subtitle:String) -> UIView {
        let titleLabel = UILabel(frame: CGRectMake(0, -5, 0, 0))
        
        titleLabel.backgroundColor = UIColor.clearColor()
        titleLabel.textColor = UIColor.blackColor()
        titleLabel.font = UIFont.boldSystemFontOfSize(17)
        titleLabel.text = title
        titleLabel.sizeToFit()
        
        let subtitleLabel = UILabel(frame: CGRectMake(0, 18, 0, 0))
        subtitleLabel.backgroundColor = UIColor.clearColor()
        subtitleLabel.textColor = UIColor.blackColor()
        subtitleLabel.font = UIFont.systemFontOfSize(12)
        subtitleLabel.text = subtitle
        subtitleLabel.sizeToFit()
        
        let titleView = UIView(frame: CGRectMake(0, 0, max(titleLabel.frame.size.width, subtitleLabel.frame.size.width), 30))
        titleView.addSubview(titleLabel)
        titleView.addSubview(subtitleLabel)
        
        let widthDiff = subtitleLabel.frame.size.width - titleLabel.frame.size.width
        
        if widthDiff > 0 {
            var frame = titleLabel.frame
            frame.origin.x = widthDiff / 2
            titleLabel.frame = CGRectIntegral(frame)
        } else {
            var frame = subtitleLabel.frame
            frame.origin.x = abs(widthDiff) / 2
            titleLabel.frame = CGRectIntegral(frame)
        }
        
        return titleView
    }
}
