//
//  ItemTableViewCell.swift
//  bykestation
//
//  Created by Luan Silva on 20/02/18.
//  Copyright © 2018 Squarebits. All rights reserved.
//

import UIKit
import SDWebImage

class ItemTableViewCell: UITableViewCell {

    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var canaleta: UILabel!
    @IBOutlet weak var stock: UILabel!
    @IBOutlet weak var nameItem: UILabel!
    @IBOutlet weak var content: UIView!
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var shadowView: UIView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setupWith(item:MachineItem){
        self.nameItem.text = item.name_item
        self.price.text = "R$ " + item.price_item!
        self.stock.text = "Em estoque: " + item.stock_item!
        self.canaleta.text = "Canaleta: " + item.raceway_item!
        
        if (item.images.isEmpty){
            self.imgView.sd_setImage(with: URL(string: ("http://via.placeholder.com/150x150")))
        }else{
            self.imgView.sd_setImage(with: URL(string: (item.images[0])))
            self.imgView.contentMode = UIViewContentMode.scaleAspectFit
        }
    }
    
}
