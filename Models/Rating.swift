//
//  Rating.swift
//  ClickServicesApp
//
//  Created by Luan Silva on 10/12/17.
//  Copyright © 2017 squarebits. All rights reserved.
//

import UIKit

class Rating: Mappable {

    var machine_id: String!
    var location: Double!
    var variation: Double!
    var price: Double!

    
    init() {}
    
    required init?(map: Map) {}
    
    func mapping(map: Map) {
        machine_id <- map["machine_id"]
        location <- map["location"]
        variation <- map["variation"]
        price <- map["price"]
    }
}


