//
//  ManualAddViewController.swift
//  CartTrackr
//
//  Created by Christina Lee on 4/10/17.
//  Copyright © 2017 Christina Lee. All rights reserved.
//

import UIKit

class ManualAddViewController: UIViewController {
    var item = Item(price: "1.99", description: "Description", quantity: 1)

    @IBOutlet weak var priceText: UITextField!
    
    @IBOutlet weak var descriptionText: UITextField!
    
    @IBOutlet weak var quantityText: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.priceText.delegate = self
        self.descriptionText.delegate = self
        self.quantityText.delegate = self
        
        self.priceText.allowsEditingTextAttributes = true
        self.descriptionText.allowsEditingTextAttributes = true
        self.quantityText.allowsEditingTextAttributes = true
        
        
        self.priceText.text = self.item.price
        self.descriptionText.text = self.item.description
        self.quantityText.text = String(self.item.quantity)
    }
    
    @IBAction func goBackButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)

    }
    

    @IBAction func addToCartButton(_ sender: Any) {
        Cart.shared.addItem(item.price, item.description, item.quantity)
    }

    
}

//MARK: UITextFieldDelegate
extension ManualAddViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if let price = priceText.text, let description = descriptionText.text, let quantity = quantityText.text {
            let enteredItem = Item(price: price, description: description, quantity: Int(quantity)!)
            item = enteredItem
            
        }
        self.quantityText.resignFirstResponder()
        
        dismiss(animated: true, completion: nil)
        return true
    }
}

