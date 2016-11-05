//
//  Travel.swift
//  goEuro
//
//  Created by Kamal Sampath Upasena on 11/5/16.
//  Copyright © 2016 self. All rights reserved.
//

import UIKit
import ObjectMapper



class Travel: Mappable {
    
    var id : Int?
    var provider_logo : String?
    var price_in_euros : String?
    var departure_time : String?
    var arrival_time : String?
    var number_of_stops : Int?
    
    
    required init?(map: Map){
        
    }
    
    func mapping(map: Map) {
        id <- map["id"]
        provider_logo <- map["provider_logo"]
        price_in_euros <- map["price_in_euros"]
        departure_time <- map["departure_time"]
        arrival_time <- map["arrival_time"]
        number_of_stops <- map["number_of_stops"]
        
    }
    
    
}

class TravelOther: Mappable {
    
    var id : Int?
    var provider_logo : String?
    var price_in_euros : Double?
    var departure_time : String?
    var arrival_time : String?
    var number_of_stops : Int?
    
    
    required init?(map: Map){
        
    }
    
    func mapping(map: Map) {
        id <- map["id"]
        provider_logo <- map["provider_logo"]
        price_in_euros <- map["price_in_euros"]
        departure_time <- map["departure_time"]
        arrival_time <- map["arrival_time"]
        number_of_stops <- map["number_of_stops"]
        
    }
    
    
}
