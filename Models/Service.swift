//
//  Service.swift
//  ClickServicesApp
//
//  Created by Luan Silva on 10/12/17.
//  Copyright © 2017 squarebits. All rights reserved.
//

import UIKit

class Service: Mappable {

    var id: Int!
    var name: String!
    var icon: String!
    var marker: String!
    var params: String!
    var childrens: [Service]!
    
    init() {}
    
    required init?(map: Map) {}
    
    func mapping(map: Map) {
        id <- map["id"]
        name <- map["name"]
        icon <- map["icon"]
        marker <- map["marker"]
        params <- map["params"]
        childrens <- map["children"]
    }
}
