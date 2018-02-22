//
//  MachineItensViewController.swift
//  bykestation
//
//  Created by Luan Silva on 20/02/18.
//  Copyright © 2018 Squarebits. All rights reserved.
//

import UIKit
import MapKit

class MachineItensViewController: BaseViewController {
    let blurView = UIView()
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var shadowView: UIView!
    @IBOutlet weak var mapView: MKMapView!
    var machine:Machine?
    var itens: [MachineItem] = []
    
    @IBOutlet weak var addressMachine: UILabel!
    @IBOutlet weak var nameMachine: UILabel!
    var regionRadius: Double = 1500.0 // distance in meeters

    
    
    //MARK: Init
    override init(nibName nibNameOrNil: String? = "MachineItensViewController", bundle nibBundleOrNil: Bundle? = nil) {
        super.init(nibName: nibNameOrNil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        addBottomBorderWithColor(shadowView, color: UIColor.black, width: 0.1)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Itens"


        
        self.nameMachine.text = machine?.loc_name
        self.addressMachine.text = machine?.loc_street
//        self.tableView.separatorStyle = UITableViewCellSeparatorStyle.none

        setupTableView()
        mapView.delegate = self
        addAnnotation()
        fetchData()
        
        let location:CLLocation = CLLocation(latitude: (machine?.loc_lat.doubleValue)!,longitude: (machine?.loc_long.doubleValue)!)
        centerMapOnLocation(location)
    }
    
    deinit {
        print("### -> DEINIT MAPVIEW <- ###")
        //deinit mapView due to memory consumed
        mapView.mapType = .hybrid
        mapView.delegate = nil
        mapView.removeFromSuperview()
        mapView = nil
    }
    
    func addAnnotation(){
        mapView.addAnnotation(PinAnnotation(machine: machine!))
        self.mapView(self.mapView, regionDidChangeAnimated: true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewWillAppear(_ animated: Bool) {
    
    }
    
    func fetchData(){
        self.addBlur(blurView: self.blurView)
            MachineRepository.getMachinesItens(idMachine: (machine?.id_machine)!,completion: { (machines,success) in
                if !success {
                    self.alert(withMessage: "Não foram encontrados itens!")
                    return
                }
                
                self.itens = machines!
                if (self.itens.count > 0){
                    self.tableView.reloadData()
                }
                
                self.removeBlur(blurView: self.blurView)
            })
    }
    
    func addBottomBorderWithColor(_ objView : UIView, color: UIColor, width: CGFloat) {
        let border = CALayer()
        border.backgroundColor = color.cgColor
        border.frame = CGRect(x: 0, y: objView.frame.size.height - width, width: objView.frame.size.width, height: width)
        objView.layer.addSublayer(border)
    }
    
    internal func centerMapOnLocation(_ location: CLLocation) {
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate, regionRadius * 5.0, regionRadius * 5.0)
        mapView.setRegion(coordinateRegion, animated: true)
    }
    
    
    //MARK: setups
    private func setupTableView() {
        tableView.dataSource = self
        self.tableView.delegate = self
        tableView.rowHeight = 145
        
        tableView.register(UINib.init(nibName: "ItemTableViewCell", bundle: nil), forCellReuseIdentifier: "ItemTableViewCell")
    }
}

extension MachineItensViewController: UITableViewDelegate,UITableViewDataSource, MKMapViewDelegate {
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

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itens.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ItemTableViewCell") as! ItemTableViewCell
        let machineItem = itens[indexPath.row]
        cell.setupWith(item: machineItem)
        return cell
    }
    
    
    // if tableView is set in attribute inspector with selection to multiple Selection it should work.
    
    // Just set it back in deselect
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        let selectedCell:UITableViewCell = tableView.cellForRow(at: indexPath as IndexPath)!
        selectedCell.contentView.backgroundColor = UIColor.white
        
        let vc = MachineDetailsViewController()
        vc.item = self.itens[indexPath.row]
        self.pushViewController(viewController: vc)
    }
    
    func tableView(tableView: UITableView, didDeselectRowAtIndexPath indexPath: NSIndexPath) {
        let deselectedCell:UITableViewCell = tableView.cellForRow(at: indexPath as IndexPath)!
        deselectedCell.contentView.backgroundColor = UIColor.white

    }
}
