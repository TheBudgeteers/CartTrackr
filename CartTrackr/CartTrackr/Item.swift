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
    var quantity : String {
        didSet {
            self.cost = (self.originalPrice * Float(self.quantity)!)
        }
    }
    
    
    init(price: String, description: String, quantity: String) {
        self.price = price
        self.originalPrice = Float(price)!
        self.cost = (Float(price)! * Float(quantity)!)
        self.description = description
        self.quantity = quantity
        
    }
}

//MARK:
extension String {
    func format() -> String {
        return String(format: "%.2f" , self)
    }
}

//extension Float {
//    func formattted( _f: Float) -> String {
//        let formatter = NumberFormatter()
//        formatter.numberStyle = NumberFormatter.Style.currency
//        return formatter.string(from: NSNumber(_f))
//    }
//}
