//
//  Item.swift
//  CartTrackr
//
//  Created by Christina Lee on 4/10/17.
//  Copyright © 2017 Christina Lee. All rights reserved.
//

import Foundation

class Item {
    var price : String
    var description : String
    var quantity : Int
    
    init(price: String, description: String, quantity: Int) {
        
        self.price = price
        self.description = description
        self.quantity = quantity
        
    }
}
