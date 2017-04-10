//
//  CartViewController.swift
//  CartTrackr
//
//  Created by Christina Lee on 4/10/17.
//  Copyright © 2017 Christina Lee. All rights reserved.
//

import UIKit

class CartViewController: UIViewController {
    var cartItems = [Item]() {
        didSet {
            self.cartTableView.reloadData()
        }
    }

    @IBOutlet weak var cartTableView: UITableView!
    
    @IBOutlet weak var totalLabel: UILabel!
    
    @IBOutlet weak var itemsLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.cartTableView.dataSource = self
//        self.cartTableView.delegate = self
        
        let itemCell = UINib(nibName: "CartItemCell", bundle: nil)
        self.cartTableView.register(itemCell, forCellReuseIdentifier: CartItemCell.identifier)
        self.cartTableView.estimatedRowHeight = 50
        self.cartTableView.rowHeight = UITableViewAutomaticDimension
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        if segue.identifier == CameraViewController.identifier {
            guard segue.destination is CameraViewController else { return }
        }
        
        if segue.identifier == ModifyViewController.identifier {
//            if let selectedIndex = self.cartTableView.indexPathForSelectedRow?.row{
//                let selectedItem : Item = cartItems[selectedIndex]
//                
//                guard let destinationController = segue.destination as? ModifyViewController else { return }
//                
//                destinationController.item = selectedItem
//            }
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

//MARK: UITableViewDataSource UITableViewDelegate
extension CartViewController : UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cartItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = cartTableView.dequeueReusableCell(withIdentifier: CartItemCell.identifier, for: indexPath) as! CartItemCell
        let item = self.cartItems[indexPath.row]
        cell.item = item
        return cell
    }
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        self.performSegue(withIdentifier: ModifyViewController.identifier, sender: nil)
//    }
    
}
