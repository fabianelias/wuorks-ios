//
//  DetailUser.swift
//  Wuorks
//
//  Created by Fabian on 24-07-16.
//  Copyright © 2016 Fabian. All rights reserved.
//

import UIKit
import Alamofire
import SVProgressHUD
import MapKit
class DetailUser: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate  {
    
    var gbf = Globals_functions()
    var config = Config()
    
    
    var username:String! = ""
    var wuorks_key = ""
    var key_profession = ""
    
    @IBOutlet weak var avatarWuokers: UIImageView!
    @IBOutlet weak var professionWuokers: UILabel!
    @IBOutlet weak var imgBG: UIImageView!
    @IBOutlet weak var scrollDetail: UIScrollView!
    @IBOutlet weak var usernameLabel: UILabel!
    
    @IBOutlet weak var imgBgDescription: UIImageView!
    @IBOutlet weak var labelDescription: UILabel!
    @IBOutlet weak var mapUser: MKMapView!
    
    override func viewDidLoad() {
        CView()
        super.viewDidLoad()
        
        scrollDetail.contentSize.height = 1500
        let userTitle:String! = username.stringByReplacingOccurrencesOfString("@", withString: "")
        print(userTitle.lowercaseString)//\()
        
        //
        SVProgressHUD.showWithStatus("Cargando...")
        load_information()
        SVProgressHUD.dismiss()
        
    }
    
    
    func load_information(){
        
        
        let url = config.url_api+"profession/infoProfession/wuorks_key/"+wuorks_key+"/key_profession/"+key_profession+"/key/"+config.key_public
        //print(url)
        Alamofire.request(.GET, url).responseJSON { response in
            if let Res = response.result.value{
                
                let wuoker = Res as! NSArray
                //print(wuoker)
                let name = wuoker[0]["username"] as! String
                let job  = wuoker[0]["name_profession"] as! String
                let descjob  = wuoker[0]["job_description"] as! String
                let address  = wuoker[0]["address"] as! String
                let imageUser = wuoker[0]["avatar"] as! String
                self.title = name
                
                let jobTitle:String! = job.stringByReplacingOccurrencesOfString("+", withString: " ")
                self.professionWuokers.text = "Profesión - \(jobTitle)"
                self.labelDescription.text = "\(descjob)"
                
                self.usernameLabel.text = "\(name)"
                Alamofire.request(.GET, "https://www.wuorks.cl/asset/img/user_avatar/"+imageUser).response { (request, response, data, error) in
                    self.avatarWuokers.image = UIImage(data: data!, scale:1)
                    self.avatarWuokers.backgroundColor = self.gbf.setUiColor(0xffffff)
                    self.avatarWuokers.layer.cornerRadius = self.avatarWuokers.frame.size.width / 2
                    self.avatarWuokers.clipsToBounds = true
                    self.avatarWuokers.layer.borderWidth = 2.0
                    self.avatarWuokers.layer.borderColor = self.gbf.setUiColor(0xffffff).CGColor
                }
                
                let urlAPI = "https://maps.googleapis.com/maps/api/geocode/json"
                
                Alamofire.request(.GET, urlAPI , parameters: ["address": address]).responseJSON { response in
                    
                    if let coor = response.result.value {
                        
                        
                        let response = coor as! NSDictionary
                        
                        
                        let userId = response.objectForKey("results")!
                        let geo    = userId.valueForKeyPath("geometry")
                        let location = geo?.valueForKey("location") as! [AnyObject]
                        let  position = CLLocationCoordinate2DMake((location[0]["lat"] as! NSNumber).doubleValue, (location[0]["lng"] as! NSNumber).doubleValue )
                        
                        let annot = CustomAnnotation()
                        annot.coordinate  = position
                        annot.title       = name
                        annot.subtitle    = "Sector aproximado"
                        annot.imageName   = "markerUser.png"
                        self.mapUser.addAnnotation(annot)
                        
                        let region = MKCoordinateRegion(center: position, span: MKCoordinateSpan(latitudeDelta: 0.3, longitudeDelta: 0.3))
                        
                        self.mapUser.setRegion(region, animated: true)
                        
                    }
                }
                
                
            }
        }
        
    }
    
    
    func CView()
    {
        self.view.backgroundColor = gbf.setUiColor(0xfbfbfb)//(0xe9ebee)
       
        self.navigationController?.navigationBar.barTintColor = gbf.setUiColor(0x2895F1)//UIColor.redColor()
        self.imgBG.backgroundColor = gbf.setUiColor(0x2895F1)
        self.navigationController?.navigationBar.tintColor = gbf.setUiColor(0xfbfbfb)
        
        UINavigationBar.appearance().tintColor = gbf.setUiColor(0x2895F1)
        
        UIApplication.sharedApplication().statusBarStyle = UIStatusBarStyle.LightContent
        
        let proxyViewForStatusBar : UIView = UIView(frame: CGRectMake(0, 0,self.view.frame.size.width, 20))
        proxyViewForStatusBar.backgroundColor = gbf.setUiColor(0x2895F1)
        self.view.addSubview(proxyViewForStatusBar)
        
        
        self.imgBgDescription.layer.cornerRadius = 4
        self.imgBgDescription.clipsToBounds = true
        self.imgBgDescription.backgroundColor = gbf.setUiColor(0xffffff)
        
    }
    
    @IBAction func dismissModal(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
