//
//  Plan.swift
//  ClickServicesApp
//
//  Created by Vinicius Gibran on 10/12/17.
//  Copyright © 2017 squarebits. All rights reserved.
//

import UIKit

class Plan: Mappable {

    var id: Int16!
    var name: String!
    var identifier: String!
    var interval: Int!
    var intervalType: String!
    var price: String!
    var valueCents: Int!
    var payableWith: String!
    
    
    init() {}
    
    required init?(map: Map) {}
    
    func mapping(map: Map) {
        id <- map["id"]
        name <- map["name"]
        identifier <- map["identifier"]
        interval <- map["interval"]
        intervalType <- map["interval_type"]
        price <- map["price"]
        valueCents <- map["value_cents"]
        payableWith <- map["payable_with"]
    }
    
}
