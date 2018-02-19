//
//  Machine.swift
//  bykestation
//
//  Created by Luan Silva on 19/02/18.
//  Copyright © 2018 Squarebits. All rights reserved.
//

import UIKit

class Machine: Mappable {
    
    public var id : String?
    public var id_machine : String?
    public var id_location : String?
    public var loc_name : String?
    public var loc_street : String?
    public var loc_number : String?
    public var loc_complement : String?
    public var loc_neighborhood : String?
    public var loc_city : String?
    public var loc_state : String?
    public var loc_zipcode : String?
    public var loc_long : String!
    public var loc_lat : String!
    public var created_at : String?
    public var updated_at : String?
    
    init() {}
    
    required init?(map: Map) {}

    func mapping(map: Map) {
        id <- map["id"]
        id_machine <- map["id_machine"]
        id_location <- map["id_location"]
        loc_name <- map["loc_name"]
        loc_street <- map["loc_street"]
        loc_number <- map["loc_number"]
        loc_complement <- map["loc_complement"]
        loc_neighborhood <- map["loc_neighborhood"]
        loc_city <- map["loc_city"]
        loc_state <- map["loc_state"]
        loc_zipcode <- map["loc_zipcode"]
        loc_long <- map["loc_long"]
        loc_lat <- map["loc_lat"]
        created_at <- map["created_at"]
        updated_at <- map["updated_at"]

    }
    
    
}
