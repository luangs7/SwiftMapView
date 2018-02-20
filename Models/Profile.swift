//
//  Profile.swift
//  ClickServicesApp
//
//  Created by Luan Silva on 24/12/17.
//  Copyright © 2017 squarebits. All rights reserved.
//

import UIKit

class Profile: Mappable {

    var avatar: String = "https://s3-sa-east-1.amazonaws.com/clickservices/assets/defaults/avatar.png" //default
    var description: String?
    var discount: Int?
    var freedays: Int?
    var gid: String?
    var mobile: String?
    var period: String?
    var phone: String?
    var professionalAt: String?
    var services: [Service] = []
    var address: Address!
    var subscribed: Bool?
    var price: Double?
    var value: String? {
        didSet{
            price = Double(value!)
        }
    }
    
    init() {}
    required init?(map: Map) {}
    
    func mapping(map: Map) {
        avatar <- map["avatar"]
        description <- map["description"]
        discount <- map["discount"]
        freedays <- map["freedays"]
        gid <- map["gid"]
        mobile <- map["mobile"]
        period <- map["period"]
        phone <- map["phone"]
        professionalAt <- map["professional_at"]
        services <- map["services"]
        subscribed <- map["subscribed"]
        value <- map["value"]
        address <- map["address"]
        
    }
}
