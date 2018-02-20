//
//  Machine.swift
//  bykestation
//
//  Created by Luan Silva on 19/02/18.
//  Copyright © 2018 Squarebits. All rights reserved.
//

import UIKit

class MachineItem: Mappable {
    
    public var name_item : String?
    public var photos_item : [String] = []
    public var id_item : String?
    public var id_location : String?
    public var price_item : String?
    public var stock_item : String?
    public var raceway_item : String?
    public var id_machine : String?
    public var id_planogram : String?
    public var descp_item : String?
    public var id : String?
    public var id_good : String!
    public var images : [String] = []
    
    init() {}
    
    required init?(map: Map) {}
    
    func mapping(map: Map) {
        name_item <- map["name_item"]
        photos_item <- map["photos_item"]
        id_item <- map["id_item"]
        id_location <- map["id_location"]
        price_item <- map["price_item"]
        stock_item <- map["stock_item"]
        raceway_item <- map["raceway_item"]
        id_machine <- map["id_machine"]
        id_planogram <- map["id_planogram"]
        descp_item <- map["descp_item"]
        id <- map["id"]
        id_good <- map["id_good"]
        images <- map["images"]

    }
    
    
}
