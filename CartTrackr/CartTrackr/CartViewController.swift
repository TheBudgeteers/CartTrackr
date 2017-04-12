//
//  CartViewController.swift
//  CartTrackr
//
//  Created by Christina Lee on 4/10/17.
//  Copyright © 2017 Christina Lee. All rights reserved.
//

import UIKit

class CartViewController: UIViewController {

    @IBOutlet weak var cartTableView: UITableView!

    @IBOutlet weak var preTaxTotalLabel: UILabel!

    @IBOutlet weak var totalLabel: UILabel!
    
    @IBOutlet weak var quantityLabel: UILabel!
   
    var activeCart = Cart.shared.listItems
    
//    var deleteCellIndexPath: NSIndexPath? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.cartTableView.dataSource = self
        self.cartTableView.delegate = self
        
        let itemCell = UINib(nibName: "CartItemCell", bundle: nil)
        self.cartTableView.register(itemCell, forCellReuseIdentifier: CartItemCell.identifier)
        
//        self.cartTableView.estimatedRowHeight = 50
//        self.cartTableView.rowHeight = UITableViewAutomaticDimension
        Cart.shared.addItem("1.99", "RedBull", "2")
        Cart.shared.addItem("5.00", "Bread", "1")
        Cart.shared.addItem("2.10", "Candy", "3")
        
        
        update()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        if segue.identifier == CameraViewController.identifier {
            guard segue.destination is CameraViewController else { return }
        }
        
        if segue.identifier == ModifyViewController.identifier {
            if let selectedIndex = self.cartTableView.indexPathForSelectedRow?.row{
                let selectedItem : Item = Cart.shared.listItems[selectedIndex]
                
                guard let destinationController = segue.destination as? ModifyViewController else { return }
                
                destinationController.item = selectedItem
            }
            
        }
        
        if segue.identifier == ManualAddViewController.identifier {
            guard segue.destination is ManualAddViewController else { return }
        }
    }
    
    func update() {
        self.preTaxTotalLabel.text = "PreTax: $\(String(Cart.shared.totalPrice()))"
        self.totalLabel.text = "Total: $\(String(Cart.shared.totalTax()))"
        self.quantityLabel.text = "#: \(Cart.shared.totalQuantity())"
        self.activeCart = Cart.shared.listItems
        
        self.cartTableView.reloadData()
    }
    
    @IBAction func SaveButton(_ sender: Any) {
        self.update()
        print(self.activeCart)
    }

    @IBAction func AddManualButton(_ sender: Any) {
        self.performSegue(withIdentifier: ManualAddViewController.identifier, sender: nil)
        
    }
    
    @IBAction func AddCameraButton(_ sender: Any) {
        self.performSegue(withIdentifier: CameraViewController.identifier, sender: nil)
    }
    
    @IBAction func NewListButton(_ sender: Any) {
        Cart.shared.removeAllItems()
        self.update()
    }

}

//MARK: UITableViewDataSource UITableViewDelegate
extension CartViewController : UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.activeCart.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = cartTableView.dequeueReusableCell(withIdentifier: CartItemCell.identifier, for: indexPath) as! CartItemCell
        let item = Cart.shared.listItems[indexPath.row]
        cell.item = item
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: ModifyViewController.identifier, sender: nil)
    }

//    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: IndexPath) {
//        if editingStyle == .delete {
//            deleteCellIndexPath = indexPath as NSIndexPath
//            let cellToDelete = Cart.shared.listItems[indexPath.row]
//            handleDeleteCell(cellToDelete: [[String : String]])
//        }
//    }
//    
//    func handleDeleteCell(cellToDelete:[String : String]) -> Void {
//        if let indexPath = deleteCellIndexPath {
//            
//            Cart.shared.listItems.remove(at: indexPath.row)
//            
//            // Note that indexPath is wrapped in an array:  [indexPath]
//            self.tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
//            
//            deleteCellIndexPath = nil
//            
//            self.tableView.endUpdates()
//        }
//    }
}
