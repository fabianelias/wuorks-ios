//
//  Welcome.swift
//  Wuorks
//
//  Created by Fabian on 22-07-16.
//  Copyright © 2016 Fabian. All rights reserved.
//

import UIKit
import Foundation

class Welcome: UIViewController {
    
    //DECLARAR VARIABLES GLOBLALES
    var gbf = Globals_functions()
    
    @IBOutlet weak var imgSteps: UIImageView!
    @IBOutlet weak var titleSteps: UILabel!
    @IBOutlet weak var descrSteps: UILabel!
    
    var pageIndex: Int!
    var titleText: String!
    var imageFile: String!
    var descpText: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.imgSteps.image = UIImage(named: self.imageFile)
        self.titleSteps.text = self.titleText
        self.descrSteps.text = self.descpText
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
