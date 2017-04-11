//
//  ModifyViewController.swift
//  CartTrackr
//
//  Created by Christina Lee on 4/10/17.
//  Copyright © 2017 Christina Lee. All rights reserved.
//

import UIKit

class ModifyViewController: UIViewController {
    var item = Item(price: "1.99", description: "item", quantity: 1) {
        didSet {
            self.priceText.text = self.item.price
            self.descriptionText.text = self.item.description
            self.quantityText.text = String(self.item.quantity)
        }
    }

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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        if segue.identifier == CartViewController.identifier {
            guard segue.destination is CartViewController else { return }
        }
    }
    
    @IBAction func addToCartButton(_ sender: Any) {
        performSegue(withIdentifier: CartViewController.identifier, sender: nil)
    }



}

//MARK: UITextFieldDelegate
extension ModifyViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if let price = priceText.text, let description = descriptionText.text, let quantity = quantityText.text {
            let enteredItem = Item(price: price, description: description, quantity: Int(quantity)!)
            item = enteredItem
            Cart.shared.addItem(item.price, item.description, item.quantity)
        }
        
        dismiss(animated: true, completion: nil)
        return true
    }
}

