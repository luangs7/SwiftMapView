//
//  Subscription.swift
//  ClickServicesApp
//
//  Created by Vinicius Gibran on 10/12/17.
//  Copyright © 2017 squarebits. All rights reserved.
//

import UIKit

class Subscription: Mappable {

    var id: Int!
    var planID: Int!
    
    init() {}

    required init?(map: Map) {}
    
    func mapping(map: Map) {
        id <- map["id"]
        planID <- map["plan_id"]
    }
}
