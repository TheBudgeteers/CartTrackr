//
//  ModifyViewController.swift
//  CartTrackr
//
//  Created by Christina Lee on 4/10/17.
//  Copyright © 2017 Christina Lee. All rights reserved.
//

import UIKit

class ModifyViewController: UIViewController {
    var item : Item! {
        didSet {
//            self.priceText.text = self.item.price
//            self.descriptionText.text = self.item.description
//            self.quantityText.text = String(self.item.quantity)
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
        
        let tapRecognizer = UITapGestureRecognizer()
        tapRecognizer.addTarget(self, action: #selector(ModifyViewController.didTapView))
        self.view.addGestureRecognizer(tapRecognizer)
        
    }
    
    func didTapView(){
        self.view.endEditing(true)
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
        if let price = priceText.text, let description = descriptionText.text, let quantity = quantityText.text {
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
    
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextFieldDidEndEditingReason) {
        print("END")
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        
        textField.resignFirstResponder()

        
//        dismiss(animated: true, completion: nil)
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

