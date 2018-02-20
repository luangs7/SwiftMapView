//
//  MachineItensViewController.swift
//  bykestation
//
//  Created by Luan Silva on 20/02/18.
//  Copyright © 2018 Squarebits. All rights reserved.
//

import UIKit
import MapKit

class MachineItensViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var shadowView: UIView!
    @IBOutlet weak var mapView: MKMapView!
    
    //MARK: Init
    override init(nibName nibNameOrNil: String? = "MachineItensViewController", bundle nibBundleOrNil: Bundle? = nil) {
        super.init(nibName: nibNameOrNil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Itens"
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
    }
}
