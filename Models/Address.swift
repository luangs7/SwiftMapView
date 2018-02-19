//
//  Address.swift
//  ClickServicesApp
//
//  Created by Vinicius Gibran Gehlen Bornholdt on 19/01/18.
//  Copyright © 2018 squarebits. All rights reserved.
//

import UIKit

class Address: Mappable {

    var complete: String!
    var show: Bool!
    
    required init?(map: Map) {}
    
    func mapping(map: Map) {
        complete <- map["complete"]
        show <- map["show"]
    }
    
}
