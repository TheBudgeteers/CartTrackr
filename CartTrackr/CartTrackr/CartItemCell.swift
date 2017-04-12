//
//  CartItemCell.swift
//  CartTrackr
//
//  Created by Christina Lee on 4/10/17.
//  Copyright © 2017 Christina Lee. All rights reserved.
//

import UIKit

class CartItemCell: UITableViewCell {

    @IBOutlet weak var priceLabel: UILabel!
    
    @IBOutlet weak var descriptionLabel: UILabel!
    
    @IBOutlet weak var quantityLabel: UILabel!
    
    var item: Item! {
        didSet {
            self.priceLabel.text = "$\(String(describing: String(item.price)))"
            self.descriptionLabel.text = item.description
            self.quantityLabel.text = String(item.quantity)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
}
