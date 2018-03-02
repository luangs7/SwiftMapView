//
//  MapViewController.swift
//  bykestation
//
//  Created by Luan Silva on 19/02/18.
//  Copyright © 2018 Squarebits. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: BaseViewController {

    @IBOutlet weak var infoView: UIView!
    @IBOutlet weak var mapView: MKMapView!
    
    
    //MARK: Variables
    let blurView = UIView()
    var regionRadius: Double = 1500.0 // distance in meeters
    var selectedPinAnnotation: PinAnnotation?
    var pinSelected = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let maskPath = UIBezierPath(roundedRect: mapView.bounds,
                                    byRoundingCorners: [.topLeft, .topRight, .bottomLeft, .bottomRight],
                                    cornerRadii: CGSize(width: 15.0, height: 15.0)).cgPath
        
        infoView.layer.shadowPath = maskPath
        infoView.layer.shadowColor = UIColor.black.cgColor
        infoView.layer.shadowOpacity = 0.1
        infoView.layer.shadowRadius = 0.9
        infoView.layer.cornerRadius = 15
        
        self.fetchMapData(completion: {
            if self.session.machines.count > 0 {
                self.updateMapView()
            }
        })
        

//
//        let button = UIButton()
//        view.addSubview(button)
//        button.frame.size = CGSize(width: 240, height: 50)
//        button.center = view.center
//        button.setTitle("aag", for: .normal)
//        button.backgroundColor = .blue
//        button.addTarget(self, action: #selector(MapViewController.gotoVCB(_:)), for: .touchUpInside)
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        applyMapViewMemoryHotFix()
        
        //initial setups
        mapView.delegate = self
        checkLocationAuthorizationStatus()
        
        if selectedPinAnnotation != nil {
            var center = selectedPinAnnotation!.coordinate;
            center.latitude -= self.mapView.region.span.latitudeDelta / 8
            mapView.setCenter(center, animated: true)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        applyMapViewMemoryHotFix()
    }
    
    deinit {
        print("### -> DEINIT MAPVIEW <- ###")
        //deinit mapView due to memory consumed
        mapView.mapType = .hybrid
        mapView.delegate = nil
        mapView.removeFromSuperview()
        mapView = nil
    }

    public func checkLocationAuthorizationStatus() {
        let authStatus = CLLocationManager.authorizationStatus()
        
        if (authStatus == .authorizedWhenInUse || authStatus == .authorizedAlways){
            mapView.showsUserLocation = true
            if let location = session.userLocation {
                centerMapOnLocation(location)
            }
            
        } else {
            session.appLocationManager.requestLocation()
            view.layoutSubviews()
        }
    }
    
    internal func updateMapView() {
        dispatchMain { [weak self] in
            guard self != nil else {return}
            self!.applyMapViewMemoryHotFix()
            self!.addAnottations()
            self!.mapView(self!.mapView, regionDidChangeAnimated: true)
        }
    }
    
    
    var arrayAnnotations: [MKAnnotation] = []

    //MARK: Map updates
    func addAnottations(){
        cleanMap()
        for machine in session.machines {
            arrayAnnotations.append(PinAnnotation(machine: machine))
            mapView.addAnnotation(PinAnnotation(machine: machine))
        }
    }
    
    internal func cleanMap(){
       
        
        if mapView.overlays.count > 0 {
            mapView.removeOverlays(mapView.overlays)
        }
        
        mapView.annotations.forEach {
            if !($0 is MKUserLocation) {
                mapView.removeAnnotation($0)
            }
        }
    }

    

    internal func applyMapViewMemoryHotFix(){
        guard mapView != nil else { return }
        
        switch (self.mapView.mapType) {
        case .hybrid:
            self.mapView.mapType = .standard;
            break;
        case .standard:
            self.mapView.mapType = .hybrid;
            break;
        default:
            break;
        }
        self.mapView.mapType = .standard;
    }
    internal func centerMapOnLocation(_ location: CLLocation) {
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate, regionRadius * 5.0, regionRadius * 5.0)
        mapView.setRegion(coordinateRegion, animated: true)
    }
    

    
    
    func openBottomInfo(machine:Machine) {
        let vc = MachineBottomViewController()
        vc.modalPresentationStyle = .custom
        vc.machine = machine
        self.navigationController?.present(vc, animated: true)
    }

    
    
    //MARK: Fetch Data
    private func fetchMapData(completion: @escaping () -> ()) {
        self.addBlur(blurView: self.blurView)
        if session.userLocation != nil {
            MachineRepository.getMachines(completion: { (success) in
                if !success {
                    self.alert(withMessage: "Não foram encontrados novos resultados!")
                }
                self.removeBlur(blurView: self.blurView)
                completion()
            })
        }
    }
    
}
    //MARK: MapView
    extension MapViewController: MKMapViewDelegate {
        
        func mapView(_ mapView: MKMapView, regionDidChangeAnimated animated: Bool){
            
        
        }
        
        //add annotations on map for cluster and pins
        func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
          
                if let pin = annotation as? PinAnnotation {
                    var pinView = mapView.dequeueReusableAnnotationView(withIdentifier: "MachineAnnotation")
                    
                    pinView = pin.annotationView
                    return pinView
                }
                if (annotation is MKUserLocation){
                    return nil
                }
                return MKAnnotationView()
            
        }
        
        func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
            if view.annotation is MKUserLocation {return}
            if view.annotation is FBAnnotationCluster {return}
            
            if let annotation = view.annotation as? PinAnnotation {
                
            
                selectedPinAnnotation = annotation
                
                self.presentModalBottom(viewController: MachineBottomViewController(), machine: annotation.machine!)
//                self.openBottomInfo(machine: annotation.machine!)
                
                var center = annotation.coordinate;
                center.latitude -= self.mapView.region.span.latitudeDelta / 8
                mapView.setCenter(center, animated: true)
                mapView.deselectAnnotation(view.annotation, animated: true)

            }
        }
    }

