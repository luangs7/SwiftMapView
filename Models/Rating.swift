//
//  Rating.swift
//  ClickServicesApp
//
//  Created by Luan Silva on 10/12/17.
//  Copyright © 2017 squarebits. All rights reserved.
//

import UIKit

class Rating: Mappable {

    var id: Int!
    var user: User!
    var professionalID: Int!
    var price: Int!
    var delivery: Int!
    var quality: Int!
    var warranty: Int!
    var negociation: Int!
    var average: Average!
    
    init() {}
    
    required init?(map: Map) {}
    
    func mapping(map: Map) {
        user <- map["user"]
        id <- map["map"]
        professionalID <- map["professional_id"]
        price <- map["price"]
        delivery <- map["delivery"]
        quality <- map["quality"]
        warranty <- map["warranty"]
        negociation <- map["negociation"]
        average <- map["average"]
    }
}

class Average: Mappable {
    var totalRounded: Int!
    var based: Int!
    var total: Double! {
        didSet{
            if let t = total {
                totalRounded = Int(round(t))
            }
        }
    }
    
    required init?(map: Map) {}
    
    func mapping(map: Map) {
        total <- map["total"]
        based <- map["based"]
    }
}
