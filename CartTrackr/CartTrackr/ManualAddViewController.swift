//
//  ManualAddViewController.swift
//  CartTrackr
//
//  Created by Christina Lee on 4/10/17.
//  Copyright © 2017 Christina Lee. All rights reserved.
//

import UIKit

class ManualAddViewController: UIViewController {
    var itemArray : [Item] = []

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
        
        
        self.priceText.text = "1.99"
        self.descriptionText.text = "Enter Description"
        self.quantityText.text = "1"
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        if segue.identifier == CartViewController.identifier {
            guard segue.destination is CartViewController else { return }
        }
    }
    
    @IBAction func goBackButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)

    }
    

    @IBAction func addToCartButton(_ sender: Any) {
        let price = itemArray[0].price
        let description = itemArray[0].description
        let quantity = itemArray[0].quantity
        Cart.shared.addItem(price, description, quantity)
        itemArray.removeAll()
        self.performSegue(withIdentifier: CartViewController.identifier, sender: nil)
    }
}

//MARK: UITextFieldDelegate
extension ManualAddViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        let price = priceText.text
        let description = descriptionText.text
        let quantity = quantityText.text
        let item = Item(price: price!, description: description!, quantity: quantity!)
            
        itemArray.append(item)
        self.priceText.resignFirstResponder()
        self.descriptionText.resignFirstResponder()
        self.quantityText.resignFirstResponder()
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        switch textField {
        case priceText:
            priceText.selectedTextRange = priceText.textRange(from: priceText.beginningOfDocument, to: priceText.endOfDocument)
            break;
        case descriptionText:
            descriptionText.selectedTextRange = descriptionText.textRange(from: descriptionText.beginningOfDocument, to: descriptionText.endOfDocument)
            break;
        case quantityText:
            quantityText.selectedTextRange = quantityText.textRange(from: quantityText.beginningOfDocument, to: quantityText.endOfDocument)
            break;
        default:
            break;
        }
    }
}

