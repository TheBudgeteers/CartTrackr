//
//  CartViewController.swift
//  CartTrackr
//
//  Created by Christina Lee on 4/10/17.
//  Copyright © 2017 Christina Lee. All rights reserved.
//

import UIKit

class CartViewController: UIViewController {

    @IBOutlet weak var CartTableView: UITableView!
    
    @IBOutlet weak var TotalLabel: UILabel!
    
    @IBOutlet weak var ItemsLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        if segue.identifier == CameraViewController.identifier {
            guard segue.destination is CameraViewController else { return }
        }
        
        if segue.identifier == ModifyViewController.identifier {
            guard segue.destination is ModifyViewController else { return }
        }
    }
    
    @IBAction func SaveButton(_ sender: Any) {
    }

    @IBAction func AddManualButton(_ sender: Any) {
        self.performSegue(withIdentifier: ModifyViewController.identifier, sender: nil)
    }
    
    @IBAction func AddCameraButton(_ sender: Any) {
        self.performSegue(withIdentifier: CameraViewController.identifier, sender: nil)
    }
    
    @IBAction func NewListButton(_ sender: Any) {
    }
    
    

}
