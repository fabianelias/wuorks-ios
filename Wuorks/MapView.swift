//
//  MapView.swift
//  Wuorks
//
//  Created by Fabian on 23-07-16.
//  Copyright © 2016 Fabian. All rights reserved.
//

import UIKit
import MapKit
import SVProgressHUD
import Foundation
import Alamofire
import CoreLocation

class MapView: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {
    
    var gbf    = Globals_functions()
    var config = Config()
    let locationManeger = CLLocationManager()
    
    var  wuorks_area:String! = ""
    var nameWuokers = [String]()
    var nameService = [String]()
    var wuokersKey = [String]()
    var ProfessKey = [String]()
    
    @IBOutlet weak var mapWuorks: MKMapView!
    @IBOutlet weak var titleHead: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //self.tabBarController?.tabBar.hidden = true
        searchWuokersMap()
        myCurrentLocation()
        
        //self.title = wuorks_area
        self.navigationItem.titleView = gbf.setTitle("Resultados", subtitle: "para tu busqueda")
        
        self.titleHead.layer.cornerRadius = 20
        self.titleHead.clipsToBounds = true
        self.titleHead.backgroundColor = gbf.setUiColor(0xffffff)
        
    }
    
    func myCurrentLocation(){
        //SECCIÓN CURRENT LOCATION
        self.mapWuorks.delegate = self
        self.locationManeger.delegate = self
        self.locationManeger.desiredAccuracy = kCLLocationAccuracyBest
        self.locationManeger.requestWhenInUseAuthorization()
        self.locationManeger.startUpdatingLocation()
        self.mapWuorks.showsUserLocation = true
    }
    
    func searchWuokersMap(){
        
        //Consulta de usuarios al API
        let parameters = [
            "wuork_area": self.wuorks_area,
            "region": 0
        ]
        Alamofire.request(.POST, config.url_api + "search/search_wuorkers_V2/key/" + config.key_public, parameters:parameters as? [String : AnyObject]).responseJSON { response in
            if let Res = response.result.value{
                
                let array = Res["res"] as! NSArray
                let totalResultados = array.count
                let urlAPI = "https://maps.googleapis.com/maps/api/geocode/json"
                
                if totalResultados > 0{
                    var i: UInt = 0
                    for wuoker in array {
                        let address = wuoker["address"] as? String
                        Alamofire.request(.GET, urlAPI , parameters: ["address": address!]).responseJSON { response in
                            
                            if let coor = response.result.value {
                                
                                //print(wuoker)
                                
                                let response = coor as! NSDictionary
                                
                                
                                let userId = response.objectForKey("results")!
                                let geo    = userId.valueForKeyPath("geometry")
                                
                                let location = geo?.valueForKey("location") as! [AnyObject]
                                
                                
                                let name = wuoker["username"] as! String
                                let service = wuoker["job_description"] as! String
                                let avatarU = wuoker["avatar"] as! String
                                
                                let wuoker_key  = wuoker["wuorks_key"] as! String
                                let service_key = wuoker["key_profession"] as! String
                                
                                let position = CLLocationCoordinate2DMake((location[0]["lat"] as! NSNumber).doubleValue, (location[0]["lng"] as! NSNumber).doubleValue )
                                
                                let annot = CustomAnnotation()
                                annot.coordinate  = position
                                annot.title       = "\(name)"
                                annot.subtitle    = "\(service)"
                                annot.imageName   = "marker2.png"
                                annot.avatarUser  = "\(avatarU)"
                                annot.customProperty = "\(i)"
                                annot.accessibilityLabel = "\(i)"
                                self.mapWuorks.addAnnotation(annot)
                                
                                
                                self.nameWuokers.append("\(name)")
                                self.nameService.append("\(service)")
                                self.wuokersKey.append("\(wuoker_key)")
                                self.ProfessKey.append("\(service_key)")
                                
                            }
                        }
                    }
                    ++i
                    self.titleHead.text = "\(totalResultados) wuokers cerca de ti"
                }else{
                    self.titleHead.text = "Sin resultados"
                }
            }
        }
    }
    func mapView(mapView: MKMapView, viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView? {
        if !(annotation is CustomAnnotation) {
            return nil
        }
        let reuseId = "2"//"test"
        
        var anView = mapView.dequeueReusableAnnotationViewWithIdentifier(reuseId)
        
        if anView == nil {
            anView = MKAnnotationView(annotation: annotation, reuseIdentifier: reuseId)
            anView!.canShowCallout = true
            
        }
        else {
            anView!.annotation = annotation
        }
        
        anView!.leftCalloutAccessoryView = nil
        anView!.rightCalloutAccessoryView = UIButton(type: UIButtonType.DetailDisclosure)//DetailDisclosure
        
        let cpa = annotation as! CustomAnnotation
        
        let imageUser = cpa.avatarUser
        
        Alamofire.request(.GET, "https://www.wuorks.cl/asset/img/user_avatar/"+imageUser).response { (request, response, data, error) in
            let leftIconView = UIImageView(frame: CGRectMake(0, 0, 53, 53))
            leftIconView.image = UIImage(data: data!)
            anView!.leftCalloutAccessoryView = leftIconView
            anView!.canShowCallout = true
        }
        
        anView!.image = UIImage(named:cpa.imageName)
        
        return anView
        
    }
    
    func mapView(mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        
        if (control as? UIButton)?.buttonType == UIButtonType.DetailDisclosure {
            mapView.deselectAnnotation(view.annotation, animated: false)
            
            performSegueWithIdentifier("detailUser", sender: view)
            let backItem = UIBarButtonItem()
            backItem.title = ""
            navigationItem.backBarButtonItem = backItem
        }
        
    }
    
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations.last
        
        let center = CLLocationCoordinate2D(latitude: location!.coordinate.latitude, longitude: location!.coordinate.longitude)
        let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 1, longitudeDelta: 1))
        
        self.mapWuorks.setRegion(region, animated: true)
        
        self.locationManeger.stopUpdatingLocation()
        
    }
    
    func mapViewWillStartLoadingMap(mapView: MKMapView) {
        SVProgressHUD.showWithStatus("Cargando...")
    }
    func mapViewDidFinishLoadingMap(mapView: MKMapView) {
        SVProgressHUD.dismiss()
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        
        if segue.identifier == "detailUser"
        {
            if let destinationVC = segue.destinationViewController as? DetailUser{
            
                let username:String! = (sender as! MKAnnotationView).annotation!.title!
                
                var index:Int = 0
                let totalUser = nameWuokers.count
                
                
                for _ in 0 ..< totalUser{
                    
                    //print(username)
                    
                    if(username == nameWuokers[index]){
                        //print("username : "+username)
                        //print(nameWuokers[index])
                        break
                    }
                    
                    ++index
                }
                let wuokers_key = self.wuokersKey[index]
                let service_key = self.ProfessKey[index]
                
                destinationVC.username = username
                destinationVC.wuorks_key = wuokers_key
                destinationVC.key_profession = service_key
            }
        }
    }
    
    override func viewDidAppear(animated: Bool)
    {
        self.navigationController?.navigationBar.barTintColor = UIColor.whiteColor()
        let proxyViewForStatusBar : UIView = UIView(frame: CGRectMake(0, 0,self.view.frame.size.width, 20))
        proxyViewForStatusBar.backgroundColor = UIColor.blackColor()
        self.view.addSubview(proxyViewForStatusBar)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
