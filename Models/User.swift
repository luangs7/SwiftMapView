//
//  User.swift
//  ClickServicesApp
//
//  Created by Vinicius Gibran on 10/12/17.
//  Copyright © 2017 squarebits. All rights reserved.
//

import UIKit

enum UserType {
    case customer, professional
}

class User: Mappable {

    var id: Int!
    var name: String!
    var email: String!
    var password: String!
    var fid: String?
    var authorization: String!
    var avatar: String!
    var formattedZipCode: String!
    
    var zipCode: String! {
        didSet{
            if zipCode != nil {
                let str = zipCode.insertString(string: ".", atIndex: 2)
                formattedZipCode = str.insertString(string: "-", atIndex: 6)
            }
        }
    }
    
    lazy var userType: UserType = .customer
    
    init() {}
    
    required init?(map: Map) {}
    
    func mapping(map: Map) {
        id <- map["id"]
        name <- map["name"]
        email <- map["email"]
        password <- map["password"]
        zipCode <- map["zipcode"]
        authorization <- map["authorization"]
        avatar <- map["avatar"]
    } 
}
