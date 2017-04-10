//
//  ModifyViewController.swift
//  CartTrackr
//
//  Created by Christina Lee on 4/10/17.
//  Copyright © 2017 Christina Lee. All rights reserved.
//

import UIKit

class ModifyViewController: UIViewController {
    var item = Item(price: "price", description: "description", quantity: 0)
    
    @IBOutlet weak var priceText: UITextView!
    
    @IBOutlet weak var descriptionText: UITextView!
    
    @IBOutlet weak var quantityText: UITextView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
//        self.priceText.delegate = self
//        self.descriptionText.delegate = self
//        self.quantityText.delegate = self

        self.priceText.allowsEditingTextAttributes = true
        self.descriptionText.allowsEditingTextAttributes = true
        self.quantityText.allowsEditingTextAttributes = true

        
        self.priceText.text = String(self.item.originalPrice)
        self.descriptionText.text = self.item.description
        self.quantityText.text = String(self.item.quantity)
        
    }
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        super.prepare(for: segue, sender: sender)
//        
//        if segue.identifier == CartViewController.identifier {
//            guard segue.destination is CartViewController else { return }
//        }
//    }
//    
//    @IBAction func addToCartButton(_ sender: Any) {
//        performSegue(withIdentifier: CartViewController.identifier, sender: nil)
//    }



}

//MARK: UITextFieldDelegate
//extension ModifyViewController: UITextFieldDelegate {

//    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
//        return true
//    }
//
//    func textFieldDidBeginEditing(_ textField: UITextField) -> Bool {
//        return true
//    }
    
//    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
//        
//    }
//    
//    func textFieldDidEndEditing(_ textField: UITextField) {
//        
//    }
//}
