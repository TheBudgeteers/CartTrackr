//
//  ModifyViewController.swift
//  CartTrackr
//
//  Created by Christina Lee on 4/10/17.
//  Copyright © 2017 Christina Lee. All rights reserved.
//

import UIKit

class ModifyViewController: UIViewController {
    var item : Item! 

    @IBOutlet weak var priceText: UITextField!
    @IBOutlet weak var descriptionText: UITextField!
    @IBOutlet weak var quantityText: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Sets the delegate for the text fields
        self.priceText.delegate = self
        self.descriptionText.delegate = self
        self.quantityText.delegate = self

        //Allows editing of the text fields
        self.priceText.allowsEditingTextAttributes = true
        self.descriptionText.allowsEditingTextAttributes = true
        self.quantityText.allowsEditingTextAttributes = true
        
        //Adds observer to change text to currency format
        priceText.addTarget(self, action: #selector(myTextFieldDidChange), for: .editingChanged)
        
        //Makes Price initial selected text
        priceText.becomeFirstResponder()

        //Sets the value of the text fields to the selected item's values
        self.priceText.text = String("$\(self.item.price)")
        self.descriptionText.text = self.item.description
        self.quantityText.text = String(self.item.quantity)
        
        //Listens for tap gesture to end editing
        let tapRecognizer = UITapGestureRecognizer()
        tapRecognizer.addTarget(self, action: #selector(ModifyViewController.didTapView))
        self.view.addGestureRecognizer(tapRecognizer)
        
    }
    
    //Ends editing when called
    func didTapView(){
        self.view.endEditing(true)
    }
    
    //Makes text input currency format
    func myTextFieldDidChange(_ textField: UITextField) {
        
        if let amountString = priceText.text?.currencyInputFormatting() {
            priceText.text = amountString
        }
    }

    //Handles segue back to CartView
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        if segue.identifier == CartViewController.identifier {
            guard segue.destination is CartViewController else { return }
        }
    }
    
    //Dismisses view when Back button is pressed
    @IBAction func goBackButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    //Updates the values on the current item with the new values in the text fields
    @IBAction func addToCartButton(_ sender: Any) {
        
        
        if  let priceWithSign = priceText.text,
        let price = priceWithSign.components(separatedBy: "$").last, let description = descriptionText.text, let quantity = quantityText.text {
            item.price = price
            item.description = description
            item.quantity = quantity
            item.cost = (Float(price)! * Float(quantity)!)
            
        }
        performSegue(withIdentifier: CartViewController.identifier, sender: nil)
    }



}

//MARK: UITextFieldDelegate
extension ModifyViewController: UITextFieldDelegate {
    
    @available(iOS 10.0, *)
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextFieldDidEndEditingReason) {
        print("END")
    }
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

