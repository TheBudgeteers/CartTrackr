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
    
    var targetPrice : String? {
        didSet {
            print("in manual add \(String(describing: targetPrice))")
            
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
        populateTextFields()


    }
    
//    print("in manual add \(String(describing: targetPrice))")
//    populateTextFields()
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        if segue.identifier == CartViewController.identifier {
            guard segue.destination is CartViewController else { return }
        }
    }
    
    func populateTextFields() {
        if targetPrice != "" {
            self.priceText.text = String(describing: targetPrice!)
            
        } else {
            self.priceText.text = "1.99"
        }
        self.descriptionText.text = "Enter Description"
        self.quantityText.text = "1"
    }
    
    @IBAction func goBackButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }

    @IBAction func addToCartButton(_ sender: Any) {
        
        let price = priceText.text ?? "1.99"
        let description = descriptionText.text ?? "Enter Description"
        let quantity = quantityText.text ?? "1"
        Cart.shared.addItem(price, description, quantity)

        //targetPrice = nil

        self.performSegue(withIdentifier: CartViewController.identifier, sender: nil)
    }
}

//MARK: UITextFieldDelegate
extension ManualAddViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        textField.resignFirstResponder()
        
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

