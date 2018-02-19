//
//  Click.swift
//  ClickServicesApp
//
//  Created by Vinicius Gibran Gehlen Bornholdt on 15/01/18.
//  Copyright © 2018 squarebits. All rights reserved.
//

import UIKit

class Click: Mappable {

    var id: Int!
    var month: Int!
    var year: Int!
    var clicks: Int!
    
    required init?(map: Map) {}
    
    func mapping(map: Map) {
        id <- map["id"]
        month <- map["month"]
        year <- map["year"]
        clicks <- map["clicks"]
    }
}
