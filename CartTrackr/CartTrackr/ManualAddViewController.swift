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
    
    var targetPrice : String? = "" {
        didSet {
            print("in manual add \(String(describing: targetPrice))")
            
        }
    }
    
    @IBOutlet weak var priceText: UITextField!
    
    @IBOutlet weak var descriptionText: UITextField!
    
    @IBOutlet weak var quantityText: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Setting delegates
        self.priceText.delegate = self
        self.descriptionText.delegate = self
        self.quantityText.delegate = self
        
        //Allowing the text to be edited on the text fields
        self.priceText.allowsEditingTextAttributes = true
        self.descriptionText.allowsEditingTextAttributes = true
        self.quantityText.allowsEditingTextAttributes = true
        populateTextFields()
        
        //Adding gesture recognizer to handle taps on the screen
        let tapRecognizer = UITapGestureRecognizer()
        tapRecognizer.addTarget(self, action: #selector(ManualAddViewController.didTapView))
        self.view.addGestureRecognizer(tapRecognizer)
        
    }
    
    //Function to end editing when the view is tapped
    func didTapView(){
        self.view.endEditing(true)
    }
    
    //Handles segue back to CartView
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        if segue.identifier == CartViewController.identifier {
            guard segue.destination is CartViewController else { return }
        }
    }
    
    //Fills Price field with text from OCR, or sets default value; fills other fields with default values
    func populateTextFields() {
        if targetPrice != "" {
            self.priceText.text = String(describing: targetPrice!)
        } else {
            self.priceText.text = "0.00"
        }
        self.descriptionText.text = "Item"
        self.quantityText.text = "1"
    }
    
    //Dismiss view when back button is pressed
    @IBAction func goBackButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    //Adds item to cart using values from the text fields, or default values if nil
    @IBAction func addToCartButton(_ sender: Any) {
        
        let price = priceText.text ?? "1.99"
        let description = descriptionText.text ?? "Enter Description"
        let quantity = quantityText.text ?? "1"
        Cart.shared.addItem(price, description, quantity)
        
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

