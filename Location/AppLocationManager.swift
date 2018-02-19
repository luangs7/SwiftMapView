//
//  AppLocationManager.swift
//  ClickServicesApp
//
//  Created by Vinicius Gibran on 12/12/17.
//  Copyright © 2017 squarebits. All rights reserved.
//

import UIKit
import CoreLocation

class AppLocationManager: NSObject, CLLocationManagerDelegate {
    
    let locationManager = CLLocationManager()
    
    override init() {
        super.init()
        //registerNotification("LOCATION_UPDATED", withSelector: #selector(stopLocation))
    }
    
    func requestLocation() {
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        Session.shared.userLocation = locationManager.location
    }
    
    // MARK: CLLocationManagerDelegate
    
    func startLocation() {
        locationManager.requestAlwaysAuthorization()
        locationManager.desiredAccuracy = kCLLocationAccuracyBestForNavigation
        locationManager.activityType = .fitness
        locationManager.pausesLocationUpdatesAutomatically = true
        locationManager.distanceFilter = 10
        locationManager.startUpdatingLocation()
    }
    
    func stopLocation() {
        locationManager.stopUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        if let lastLocation = locations.last {
            Session.shared.userLocation = lastLocation
        }
        
        locationManager.stopUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
//        AlertUtils.alert("Atenção!", message: error.localizedDescription)
        AlertUtils.alert("Atenção!", message: "Ocorreu um erro ao pegar sua localização, tente novamente.")
    }
    
    
}
