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
    
    @IBOutlet weak var priceText: UITextView!
    
    @IBOutlet weak var descriptionText: UITextView!
    
    @IBOutlet weak var quantityText: UITextView!

    override func viewDidLoad() {
        super.viewDidLoad()
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
    



}
