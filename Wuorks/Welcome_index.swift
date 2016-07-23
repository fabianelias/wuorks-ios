//
//  Welcome_index.swift
//  Wuorks
//
//  Created by Fabian on 22-07-16.
//  Copyright © 2016 Fabian. All rights reserved.
//

import UIKit

class Welcome_index: UIViewController, UIPageViewControllerDataSource {
    
    var pageViewController: UIPageViewController!
    var pageTitles: NSArray!
    var pageDescrp: NSArray!
    var pageImages: NSArray!
    
    var globalFunction = Globals_functions()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.pageTitles = NSArray(objects: "Eres el mejor", "Profesionales","Califica")
        
        self.pageDescrp = NSArray(objects:
            "Consigue ingresos extra haciendo lo que mejor sabes, crea un perfil de tu servicio, detalla toda tu experiencia y listo.",
            "Busca y selecciona en el mapa el Wuokers más cercano o mejor evaluado cerca de ti",
            "Si recibes el servicio de un wuokers ! valoralo ")
        
        self.pageImages = NSArray(objects: "pass1", "pass2","pass3")
        
        
        self.pageViewController = self.storyboard?.instantiateViewControllerWithIdentifier("PageViewController") as! UIPageViewController
        
        self.pageViewController.dataSource = self
        
        
        let startVC = self.viewControllerAtIndex(0) as Welcome
        
        let viewControllers = NSArray(object: startVC)
        
        self.pageViewController.setViewControllers(viewControllers as? [UIViewController], direction: .Forward, animated: true, completion: nil)
        
        
        
        
        self.pageViewController.view.frame = CGRectMake(0,-20, self.view.frame.width, self.view.frame.size.height - 40)
        
    5
        
        self.addChildViewController(self.pageViewController)
        
        self.view.addSubview(self.pageViewController.view)
        
        self.pageViewController.didMoveToParentViewController(self)
        
        
    }
    
    func viewControllerAtIndex(index: Int) -> Welcome{
        if ((self.pageTitles.count == 0) || (index >= self.pageTitles.count)) {
            
            return Welcome()
            
        }
        
        
        
        let vc: Welcome = self.storyboard?.instantiateViewControllerWithIdentifier("ContentViewController") as! Welcome
        
        
        
        vc.imageFile = self.pageImages[index]as! String
        
        vc.titleText = self.pageTitles[index]as! String
        
        vc.descpText = self.pageDescrp[index]as! String
        
        vc.pageIndex = index
        
        
        return vc
        
        
    }
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerBeforeViewController viewController: UIViewController) -> UIViewController?
        
    {
        
        let vc = viewController as! Welcome
        
        var index = vc.pageIndex as Int
        
        if (index == 0 || index == NSNotFound)
            
        {
            
            return nil
            
        }
        
        index -= 1
        
        return self.viewControllerAtIndex(index)
        
    }
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController?{
        
        
        let vc = viewController as! Welcome
        var index = vc.pageIndex as Int
        
        if (index == NSNotFound){
            return nil
        }
        
        index += 1
        
        if (index == self.pageTitles.count){
            return nil
        }
        
        return self.viewControllerAtIndex(index)
        
    }
    
    func presentationCountForPageViewController(pageViewController: UIPageViewController) -> Int {
        return self.pageTitles.count
    }
    
    func presentationIndexForPageViewController(pageViewController: UIPageViewController) -> Int {
        return 0
    }
}
