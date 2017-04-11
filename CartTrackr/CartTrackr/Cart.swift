//
//  Cart.swift
//  CartTrackr
//
//  Created by Brandon Little on 4/10/17.
//  Copyright © 2017 Christina Lee. All rights reserved.
//

import Foundation

class Cart {
    private var listItems = [Item]()
    
    static let shared = Cart()
    
    private init() {
        
    }
    
    func addItem(_ price: String,_ description: String,_ quantity: Int) {
        self.listItems.append(Item.init(price: price, description: description, quantity: quantity))
    }
    
    func removeItem(_ index: Int) {
        self.listItems.remove(at: index)
    }
    
    func removeAllItems() {
        self.listItems.removeAll()
    }
    
    func totalPrice() -> String {
        var total : Float = 0.00
        
        for item in self.listItems {
            total += item.cost
        }
        
        return String("$\(total)")
    }
    
    func totalQuantity() -> Int {
        var total : Int = 0
        
        for item in self.listItems {
            total += item.quantity
        }
        
        return total
    }
}
