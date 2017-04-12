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
    
    var deleteCellIndexPath: IndexPath? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.cartTableView.dataSource = self
        self.cartTableView.delegate = self
        
        let itemCell = UINib(nibName: "CartItemCell", bundle: nil)
        self.cartTableView.register(itemCell, forCellReuseIdentifier: CartItemCell.identifier)
        
        update()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
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
        return Cart.shared.listItems.count
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

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            deleteCellIndexPath = indexPath
            let cellToDelete = Cart.shared.listItems[indexPath.row]
            handleDeleteCell(cellToDelete: cellToDelete)
        }
    }
    
    func handleDeleteCell(cellToDelete: Item) -> Void {
        if let indexPath = deleteCellIndexPath {
            
            Cart.shared.listItems.remove(at: indexPath.row)
            
            self.update()
            self.cartTableView.reloadData()
        }
    }
}
