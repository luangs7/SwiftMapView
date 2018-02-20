//
//  Session.swift
//  ClickServicesApp
//
//  Created by Luan Silva on 16/11/17.
//  Copyright © 2017 squarebits. All rights reserved.
//

import UIKit
import CoreLocation



class Session {
    
    private let kToken = "TOKEN_KEY"
    
    //singleton
    static var shared = Session()
    private init() {}

    //cache list
    lazy var machines: [Machine] = []
   
    
    //variables
    
    
    var accessToken: String? {
        set{ UserDefault.setString(newValue, forKey: kToken) }
        get{ return UserDefault.getString(kToken) }
    }
    
    //MARK: - Location
    let appLocationManager = AppLocationManager()
    var userLocation: CLLocation? {
        didSet {
            //tmp
            let initialLocation = CLLocation(latitude: -25.429715, longitude: -49.271995)
            userLocation = initialLocation
        }
    }
    
    func logout() {
      
    }
}
