//
//  MachineDetailsViewController.swift
//  bykestation
//
//  Created by Luan Silva on 20/02/18.
//  Copyright © 2018 Squarebits. All rights reserved.
//

import UIKit
import ImageSlideshow

class MachineDetailsViewController: BaseViewController {
    @IBOutlet weak var nameProduct: UILabel!
    @IBOutlet weak var slider: ImageSlideshow!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var stock: UILabel!
    @IBOutlet weak var canaleta: UILabel!
    @IBOutlet weak var desc: UILabel!
    var item:MachineItem?
    let blurView = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = item?.name_item
        fetchData()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
 
    
    //MARK: Init
    override init(nibName nibNameOrNil: String? = "MachineDetailsViewController", bundle nibBundleOrNil: Bundle? = nil) {
        super.init(nibName: nibNameOrNil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func fetchData(){
        self.addBlur(blurView: self.blurView)
        MachineRepository.getMachineItem(idMachine: (item?.id_machine)!,idItem: (item?.id_item)!,completion: { (item,success) in
            if !success {
                self.alert(withMessage: "Não foram encontrados itens!")
                self.removeBlur(blurView: self.blurView)
                return
            }
            
            self.item = item!
            if (self.item != nil){
                self.initView()
            }else{
                self.alert(withMessage: "Erro ao visualizar item.")
            }
            
            self.removeBlur(blurView: self.blurView)

        })
        

    }

    
    func initView(){
        var kingfisherSource: [AFURLSource] = []
        var photos : [String] = (self.item?.images)!
//        photos.append(self.item?.photos_item)
        photos = (self.item?.images)!
        if(photos.count > 0){
            for url in photos {
                kingfisherSource.append(AFURLSource(urlString: url)!)
            }
        }else{
             kingfisherSource.append(AFURLSource(urlString: "http://via.placeholder.com/500x250")!)
             kingfisherSource.append(AFURLSource(urlString: "http://via.placeholder.com/450x250")!)
        }
    
        self.nameProduct.text = self.item?.name_item
        self.price.text = self.item?.price_item
        self.stock.text = self.item?.stock_item
        self.canaleta.text = self.item?.raceway_item
        if(self.item?.descp_item != nil){
            self.desc.text = self.item?.descp_item
        }else{
                self.desc.text = "Sem descriçāo de produto."
        }
        slider.backgroundColor = UIColor.white
        slider.slideshowInterval = 5.0
        slider.pageControlPosition = PageControlPosition.underScrollView
        slider.pageControl.currentPageIndicatorTintColor = UIColor.lightGray
        slider.pageControl.pageIndicatorTintColor = UIColor.black
        slider.contentScaleMode = UIViewContentMode.scaleAspectFit

        slider.setImageInputs(kingfisherSource)
        
        let recognizer = UITapGestureRecognizer(target: self, action: #selector(MachineDetailsViewController.didTap))
        slider.addGestureRecognizer(recognizer)


    }
    
    
    
    func didTap() {
        let fullScreenController = slider.presentFullScreenController(from: self)
        // set the activity indicator for full screen controller (skipping the line will show no activity indicator)
//        fullScreenController.slider.indi = DefaultActivityIndicator(style: .white, color: nil)
    }
}
