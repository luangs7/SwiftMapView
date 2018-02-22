//
//  MachineBottomViewController.swift
//  bykestation
//
//  Created by Luan Silva on 19/02/18.
//  Copyright © 2018 Squarebits. All rights reserved.
//

import UIKit
import MapKit

class MachineBottomViewController: BaseViewController {

    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var address: UILabel!
    @IBOutlet weak var route: UIView!
    @IBOutlet weak var itens: UIView!
    @IBOutlet weak var rating: UILabel!
    
    
    var machine:Machine? = nil
    
    lazy var backdropView: UIView = {
        let bdView = UIView(frame: self.view.bounds)
        bdView.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        return bdView
    }()
    
    var menuView = UIView()
    let menuHeight = UIScreen.main.bounds.height / 3
    var isPresenting = false
    
    init() {
        super.init(nibName: nil, bundle: nil)
        menuView = instanceFromNib()
        modalPresentationStyle = .custom
        transitioningDelegate = self
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .clear
        view.addSubview(backdropView)
        view.addSubview(menuView)
        
        //        menuView.backgroundColor = .red
        
        updateMenuViewLayout()
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(MachineBottomViewController.handleTap(_:)))
        backdropView.addGestureRecognizer(tapGesture)
        
        self.name.text = self.machine?.loc_name
        self.address.text = self.machine?.loc_street
        let gestureRec = UITapGestureRecognizer(target: self, action:  #selector (self.showItens (_:)))
        self.itens.addGestureRecognizer(gestureRec)
        let gestureRecRoute = UITapGestureRecognizer(target: self, action:  #selector (self.showMap(_:)))
        self.route.addGestureRecognizer(gestureRecRoute)
    }
    
    func updateMenuViewLayout(){
        menuView.translatesAutoresizingMaskIntoConstraints = false
        menuView.heightAnchor.constraint(equalToConstant: menuHeight).isActive = true
        menuView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        menuView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        menuView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        view.addConstraint(NSLayoutConstraint(item: menuView, attribute: .bottom, relatedBy: .equal, toItem: self.bottomLayoutGuide, attribute:.top, multiplier: 1, constant: -20))
        view.addConstraint(NSLayoutConstraint(item: menuView, attribute: .left, relatedBy: .equal, toItem: view, attribute:.left, multiplier: 1, constant: 16))
        view.addConstraint(NSLayoutConstraint(item: menuView, attribute: .right, relatedBy: .equal, toItem: view, attribute:.right, multiplier: 1, constant: -16))
        
        let maskPath = UIBezierPath(roundedRect: view.bounds,
                                    byRoundingCorners: [.topLeft, .topRight, .bottomLeft, .bottomRight],
                                    cornerRadii: CGSize(width: 15.0, height: 15.0)).cgPath
        
        menuView.layer.shadowPath = maskPath
        menuView.layer.shadowColor = UIColor.black.cgColor
        menuView.layer.shadowOpacity = 0.1
        menuView.layer.shadowRadius = 0.9
        menuView.layer.cornerRadius = 20

    }
    
    
    func showItens(_ sender:UITapGestureRecognizer){
        let vc = MachineItensViewController()
        vc.machine = self.machine
        self.pushViewController(viewController: vc)
    }
    
    func showMap(_ sender:UITapGestureRecognizer){
        let coordinate = CLLocationCoordinate2DMake((machine?.loc_lat.doubleValue)!, (machine?.loc_long.doubleValue)!)
        let mapItem = MKMapItem(placemark: MKPlacemark(coordinate: coordinate, addressDictionary:nil))
        mapItem.name = machine?.loc_name
        mapItem.openInMaps(launchOptions: [MKLaunchOptionsDirectionsModeKey : MKLaunchOptionsDirectionsModeDriving])
    }
    
    func handleTap(_ sender: UITapGestureRecognizer) {
        dismiss(animated: true, completion: nil)
    }
    
    func instanceFromNib() -> UIView {
        return UINib(nibName: "BottomView", bundle: nil).instantiate(withOwner: self, options: nil)[0] as! UIView
    }
}

extension MachineBottomViewController: UIViewControllerTransitioningDelegate, UIViewControllerAnimatedTransitioning {
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return self
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return self
    }
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 1
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let containerView = transitionContext.containerView
        let toViewController = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to)
        guard let toVC = toViewController else { return }
        isPresenting = !isPresenting
        
        if isPresenting == true {
            containerView.addSubview(toVC.view)
            
            menuView.frame.origin.y += menuHeight
            backdropView.alpha = 0
            
            UIView.animate(withDuration: 0.4, delay: 0, options: [.curveEaseOut], animations: {
                self.menuView.frame.origin.y -= self.menuHeight
                self.backdropView.alpha = 1
            }, completion: { (finished) in
                transitionContext.completeTransition(true)
            })
        } else {
            UIView.animate(withDuration: 0.4, delay: 0, options: [.curveEaseOut], animations: {
                self.menuView.frame.origin.y += self.menuHeight
                self.backdropView.alpha = 0
            }, completion: { (finished) in
                transitionContext.completeTransition(true)
            })
        }
}

}
