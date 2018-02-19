//
//  PinAnnotation.swift
//  ClickServicesApp
//
//  Created by Vinicius Gibran on 12/12/17.
//  Copyright © 2017 squarebits. All rights reserved.
//

import UIKit
import MapKit

class PinAnnotation: NSObject, MKAnnotation{
    
    init(machine: Machine) {
        self.machine = machine
        self.title = machine.loc_name
    }
    
    var machine: Machine!
    var title: String?
    
    var annotationView: MKAnnotationView {
        get {
            let annotation = MKAnnotationView(annotation: self, reuseIdentifier: "MachineAnnotation")
            
            // pin with re-size image
            let pinImage = UIImageView()
            pinImage.image = UIImage(named: "pin")
                let size = CGSize(width: 40, height: 40)
                UIGraphicsBeginImageContext(size)
                pinImage.image?.draw(in: CGRect(x: 0, y: 0, width: size.width, height: size.height), blendMode: .normal, alpha: 1.0)
                
                let resizedImage = UIGraphicsGetImageFromCurrentImageContext()
                UIGraphicsEndImageContext()
                
                annotation.isEnabled = true
                annotation.canShowCallout = false
                annotation.image = resizedImage
                annotation.tag = Int(self.machine.id_machine!)!
            
            return annotation
        }
    }
    
    var coordinate: CLLocationCoordinate2D {
        get {
            guard let lat = machine.loc_lat else {return CLLocationCoordinate2D()}
            guard let long = machine.loc_long else {return CLLocationCoordinate2D()}
            let latitude = Double(lat)
            let longitude = Double(long)
            
            if let _ = latitude, let _ = longitude {
                return CLLocationCoordinate2D(latitude: latitude!, longitude: longitude!)
            }
            return CLLocationCoordinate2D()
        }
    }
}
