//
//  DetailViewController.swift
//  goEuro
//
//  Created by Kamal Sampath Upasena on 11/5/16.
//  Copyright © 2016 self. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireObjectMapper
import ImageLoader

class DetailViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    let kDetailViewTableViewCell = "DetailViewTableViewCell"
    
    let getFlightDetails = "https://api.myjson.com/bins/w60i"
    let getBusDetails =  "https://api.myjson.com/bins/37yzm"
    let getTrainDetails = "https://api.myjson.com/bins/3zmcy"
    let provideImageSize = 63
    
    var travelType : TravelType!
    var travelArray  = [Travel]()
    var travelOtherArray  = [TravelOther]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        let nib = UINib(nibName: kDetailViewTableViewCell, bundle:nil)
        self.tableView.register(nib, forCellReuseIdentifier: kDetailViewTableViewCell)
        
        
        switch travelType! {
        case .Flight :
            downloadData(urlString: getFlightDetails)
            break
        case .Train :
            downloadDataOther(urlString: getTrainDetails)
            break
        case .Bus :
            downloadDataOther(urlString: getBusDetails)
            break
        }
        
        
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func downloadData(urlString : String){
        
        
        
        Alamofire.request(urlString)
            .responseArray { (response: DataResponse<[Travel]>) in
                self.travelArray =  response.result.value!
                self.tableView.reloadData()
        }
        
    }
    
    func downloadDataOther(urlString : String){
        
        Alamofire.request(urlString)
            .responseArray { (response: DataResponse<[TravelOther]>) in
                self.travelOtherArray =  response.result.value!
                self.tableView.reloadData()
        }
        
    }
    
}

extension DetailViewController : UITableViewDataSource {}

extension DetailViewController : UITableViewDelegate {
    
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0
    }
    
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1;
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch travelType! {
        case .Flight:
            return travelArray.count
        case .Train,.Bus :
            return travelOtherArray.count
        }
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: kDetailViewTableViewCell, for: indexPath) as! DetailViewTableViewCell
        
        switch travelType! {
        case .Flight:
            
            let travel = travelArray[indexPath.row]
            
            cell.lblArivalTime.text = travel.arrival_time
            cell.lblDepathureTime.text = travel.departure_time
            
            let priceDetials = String(describing: travel.price_in_euros!).components(separatedBy: ".")
            
            cell.lblPriceBig.text = priceDetials[0]
            cell.lblPriceSmall.text = priceDetials[1]
            
            let provideImageUrl = travel.provider_logo?.replacingOccurrences(of: "{size}", with: String(provideImageSize))
            
            cell.imgProviderLogo.load(provideImageUrl!){ URL, image, error, cacheType in
                
                if cacheType == CacheType.none {
                    let transition = CATransition()
                    transition.duration = 0.5
                    transition.type = kCATransitionFade
                    cell.imgProviderLogo.layer.add(transition, forKey: nil)
                    cell.imgProviderLogo.image = image
                }
            }
            cell.imgProviderLogo.contentMode = .scaleAspectFit
            cell.imgProviderLogo.clipsToBounds = true
            
            cell.lblNumberOfStops.text = String(format: "%d",travel.number_of_stops!)
            
            cell.lblDuration.text = String(format : "%.2d h",durationCalculator(depatureTime: travel.departure_time!, arivalTime: travel.arrival_time!))
            
            break
        case .Train,.Bus :
            
            let travel = travelOtherArray[indexPath.row]
            
            cell.lblArivalTime.text = travel.arrival_time
            cell.lblDepathureTime.text = travel.departure_time
            
            let priceDetials = String(describing: travel.price_in_euros!).components(separatedBy: ".")
            
            
            cell.lblPriceBig.text = priceDetials[0]
            cell.lblPriceSmall.text = priceDetials[1]
            
            let provideImageUrl = travel.provider_logo?.replacingOccurrences(of: "{size}", with: String(provideImageSize))
            
            cell.imgProviderLogo.load(provideImageUrl!){ URL, image, error, cacheType in
                
                if cacheType == CacheType.none {
                    let transition = CATransition()
                    transition.duration = 0.5
                    transition.type = kCATransitionFade
                    cell.imgProviderLogo.layer.add(transition, forKey: nil)
                    cell.imgProviderLogo.image = image
                }
            }
            cell.imgProviderLogo.contentMode = .scaleAspectFit
            cell.imgProviderLogo.clipsToBounds = true
            
            cell.lblNumberOfStops.text = String(format: "%d",travel.number_of_stops!)
            
            cell.lblDuration.text = String(format : "%.2d h",durationCalculator(depatureTime: travel.departure_time!, arivalTime: travel.arrival_time!))
            
            break
            
        }
        
        
        return cell
    }
    
    func durationCalculator(depatureTime : String , arivalTime : String) -> Double{
        
        let  df = DateFormatter()
        df.dateFormat = "HH:mm"
        
        let depature = df.date(from: depatureTime)
        let arrival = df.date(from: arivalTime)
        

        let duration = arrival?.timeIntervalSince(depature!)
        
        return Double(duration!)
    }
    
    
}
