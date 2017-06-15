    //
//  Cart.swift
//  CartTrackr
//
//  Created by Brandon Little on 4/10/17.
//  Copyright © 2017 Christina Lee. All rights reserved.
//

import Foundation

class Cart {
    
    var listItems = [Item]()
    
    static let shared = Cart()
    
    private init() {
        
    }
    
    //add and remove class methods
    func addItem(_ price: String,_ description: String,_ quantity: String) {
        self.listItems.append(Item.init(price: price, description: description, quantity: quantity))
        //print(self.listItems)
    }
    
    func removeItem(_ index: Int) {
        self.listItems.remove(at: index)
    }
    
    func removeAllItems() {
        self.listItems.removeAll()
    }
    
    //methods for totals drawn from singleton listItems
    func totalPrice() -> Float {
        var total : Float = 0.00
        
        for item in self.listItems {
            total += item.cost
        }
        
        return total
    }
    
    func totalQuantity() -> Int {
        var total : Int = 0
        
        for item in self.listItems {
            total += Int(item.quantity)!
        }
        
        return total
    }
    
    func totalTax() -> Float {
        let tax : Float = 1.096
        let totalPrice = Cart.shared.totalPrice()
        let total = round((totalPrice * tax) * 100) / 100
        return total
    }
    
    func percentageTotal(budget: String) -> Float {
        let budget : Float = Float(budget)!
        print("budget \(budget)")
        let total : Float = self.totalPrice()
        let percent : Float = total / budget
        return percent
    }
    
    func percentageTax(budget: String) -> Float {
        let budget : Float = Float(budget)!
        print("budget \(budget)")
        let total : Float = self.totalTax()
        let percent : Float = total / budget
        return percent
    }
    
}








