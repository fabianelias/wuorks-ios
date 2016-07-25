//
//  Contracts.swift
//  Wuorks
//
//  Created by Fabian on 24-07-16.
//  Copyright © 2016 Fabian. All rights reserved.
//

import UIKit

class Contracts: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
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
        // Dispose of any resources that can be recreated.
    }
    
}
