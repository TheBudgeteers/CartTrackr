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
    var originalPrice : Float
    var cost : Float
    var description : String
    var quantity : Int = 1 {
        didSet {
            self.cost = (self.originalPrice * Float(self.quantity))
        }
    }
    
    
    init(price: String, description: String, quantity: Int) {
        self.price = price
        self.originalPrice = Float(price.format(".2"))!
        self.cost = (Float(price)! * Float(quantity))
        self.description = description
        self.quantity = quantity
        
    }
}

//MARK:
extension String {
    func format( _ f: String) -> String {
        return String(format: "%\(f)f", self)
    }
}
