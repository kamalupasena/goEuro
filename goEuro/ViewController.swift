//
//  ViewController.swift
//  goEuro
//
//  Created by Kamal Sampath Upasena on 11/5/16.
//  Copyright © 2016 self. All rights reserved.
//

import UIKit

public enum TravelType : String{
    case Flight = "Flight"
    case Train  = "Train"
    case Bus    = "Bus"
}

class ViewController: UIViewController,CAPSPageMenuDelegate{

    var pageMenu : CAPSPageMenu?
    var tabs : [UIViewController] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        
        let FlightsController : DetailViewController = self.storyboard!.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
        FlightsController.title = TravelType.Flight.rawValue
        FlightsController.travelType = .Flight
        tabs.append(FlightsController)
        
        
        let TrainsController : DetailViewController = self.storyboard!.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
        TrainsController.title = TravelType.Train.rawValue
        TrainsController.travelType = .Train
        tabs.append(TrainsController)
        
        let BusController : DetailViewController = self.storyboard!.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
        BusController.title = TravelType.Bus.rawValue
        BusController.travelType = .Bus
        tabs.append(BusController)
        
        
        let pageMenuOptions: [CAPSPageMenuOption] = [
            .menuItemSeparatorWidth(4.3),
            .useMenuLikeSegmentedControl(false),
            .menuItemSeparatorPercentageHeight(0.1),
            .scrollMenuBackgroundColor(UIColor(red: 110/255, green: 102/255, blue: 255/255, alpha: 1))
            
        ]

        
        
        
        pageMenu = CAPSPageMenu(viewControllers: tabs, frame: CGRect(x :0.0, y: 0.0, width : self.view.frame.width, height : self.view.frame.height), pageMenuOptions: pageMenuOptions)
        
        
        self.view.addSubview(pageMenu!.view)
        
        pageMenu!.delegate = self
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

