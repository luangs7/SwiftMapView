//
//  RatingViewController.swift
//  bykestation
//
//  Created by Luan Silva on 23/02/18.
//  Copyright © 2018 Squarebits. All rights reserved.
//

import UIKit
import Cosmos

class RatingViewController: BaseViewController{

    @IBOutlet weak var submit: UIButton!
    @IBOutlet weak var price: CosmosView!
    @IBOutlet weak var variety: CosmosView!
    @IBOutlet weak var local: CosmosView!
    @IBOutlet weak var addressMachine: UILabel!
    @IBOutlet weak var nameMachine: UILabel!
    var machine:Machine?
    var rating:Rating?
    let blueView = UIView()
    
    
    //MARK: Init
    override init(nibName nibNameOrNil: String? = "RatingViewController", bundle nibBundleOrNil: Bundle? = nil) {
        super.init(nibName: nibNameOrNil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Avaliar"

        self.nameMachine.text = machine?.loc_name
        self.addressMachine.text = machine?.loc_street
        submit.layer.cornerRadius = 20
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    

    @IBAction func setdata(_ sender: Any) {
        self.addBlur(blurView: self.blueView)
        rating = Rating()
        rating?.machine_id = machine?.id_machine
        rating?.price = price.rating
        rating?.variation = variety.rating
        rating?.location = local.rating
        MachineRepository.postRating(rating!, completion: { [weak self](success) in
            if success {
                self?.removeBlur(blurView: (self?.blueView)!)

                let alertController = UIAlertController(title: "Obrigado!", message: "Maquina avaliada com successo.", preferredStyle: .alert)
                
                alertController.addAction(UIAlertAction(title: "Ok", style: .default, handler: {
                    alert -> Void in
                    self?.dispatchMain {
                        self?.navigationController?.popViewController(animated: true)
                    }
                }))
                
                self?.present(alertController, animated: true, completion: nil)
            }
            self?.removeBlur(blurView: (self?.blueView)!)

        })
    }
   

}
