//
//  Professional.swift
//  
//
//  Created by Luan Silva on 10/12/17.
//
//

import UIKit

class Professional: User {
    
    var latitude: String!
    var longitude: String!
    var marker: String!
    var profile: Profile!
    var identifier: String!
    var showAddress: Bool!
    var servicesID: [Int]!

    
    override func mapping(map: Map) {
        name <- map["name"]
        email <- map["email"]
        latitude <- map["latitude"]
        longitude <- map["longitude"]
        marker <- map["marker"]
        profile <- map["profile"]
        authorization <- map["authorization"]
        avatar <- map["avatar"]
        id <- map["id"]
        identifier <- map["identifier"]
        
        if let profile = self.profile {
            if profile.services.count > 0 {
                servicesID = []
                for service in profile.services {
                    servicesID.append(service.id)
                }
            }
        }
    }
    
    //toJSON
    func toJSON() -> [String : Any] {
        var dict: [String: Any] = [:]
        guard profile != nil else {
            return [:]
        }
        
        if let name = name {
            dict["name"] = name
        }
        
        if let email = email {
            dict["email"] = email
        }
        
        if let password = password {
            dict["password"] = password
        }
        
        if let identifier = identifier {
            dict["identifier"] = identifier
        }
        
        if let servicesID = servicesID {
            dict["services_ids"] = servicesID
        }
        
        if let zipCode = zipCode {
            dict["zipcode"] = zipCode
        }
        
        if let showAddress = showAddress {
            dict["show_address"] = showAddress
        }
        
        if let period = profile!.period {
            dict["period"] = period
        }
        
        if let value = profile!.value {
            dict["value"] = value
        }
        
        
        if let phone = profile!.phone {
            dict["phone"] = phone
        }
        
        if let mobile = profile!.mobile {
            dict["mobile"] = mobile
        }
        
        if let description = profile!.description {
            dict["description"] = description
        }
        
        if let discount = profile!.discount {
            dict["discount"] = discount
        }
        
        dict["avatar"] = profile!.avatar
        
        return dict
    }
}
