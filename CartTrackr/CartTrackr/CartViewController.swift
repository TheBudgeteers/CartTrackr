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
    @IBOutlet weak var budgetProgressBar: UIProgressView!
    
    @IBOutlet weak var imageBackground: UIImageView!
    
    var activeCart = Cart.shared.listItems
    
    var deleteCellIndexPath: IndexPath? = nil
    
    var userBudgetSet : String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Set dataSource and delegate for the TableView
        self.cartTableView.dataSource = self
        self.cartTableView.delegate = self
        
        //Uses CartItemCell nib for the TableView
        let itemCell = UINib(nibName: "CartItemCell", bundle: nil)
        self.cartTableView.register(itemCell, forCellReuseIdentifier: CartItemCell.identifier)
        
        update()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        update()
    }
    
    //Handle logic for moving to Camera, Modify, or ManualAdd views
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
    
    //Refreshes and updates the totals
    func update() {
        self.preTaxTotalLabel.text = "PreTax: $\(String(Cart.shared.totalPrice()))"
        self.totalLabel.text = "Total: $\(String(Cart.shared.totalTax()))"
        self.quantityLabel.text = "#: \(Cart.shared.totalQuantity())"
        
        self.activeCart = Cart.shared.listItems
        
        self.cartTableView.reloadData()
        
        //handles the logic for the budgetProgressBar
        if Budget.shared.budgetMax != nil {
            
            budgetProgressBar.isHidden = false
            
            if let budgetMax = Budget.shared.budgetMax {
                print(budgetMax)
                var percentTax = Cart.shared.percentageTax(budget: budgetMax)
                
                if percentTax >= 1.0 {
                    self.imageBackground.image = UIImage(named: "redGradientIphone")
                    percentTax = 1.0
                } else {
                    self.imageBackground.image = UIImage(named: "blueGradientIphone")
                    
                }
                
                budgetProgressBar.setProgress(percentTax, animated: true)
                
            } else { return }
        } else {
            budgetProgressBar.isHidden = true
        }
        
    }
    
    
    
    
    func textFieldDidChange(_ textField: UITextField){
        userBudgetSet = textField.text!
    }
    func dismissKeyboard(){
        view.endEditing(true)
    }
    
    func touchCancel() {
        dismissPopupView()
    }
    
    func touchClose() {
        
        Budget.shared.budgetMax = userBudgetSet
        dismissPopupView()
        update()
        
    }
    
    func hexStringToUIColor (hex:String) -> UIColor {
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }
        
        if ((cString.characters.count) != 6) {
            return UIColor.gray
        }
        
        var rgbValue:UInt32 = 0
        Scanner(string: cString).scanHexInt32(&rgbValue)
        
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
    
    //Opens popup for setting the budget
    @IBAction func SetBudget(_ sender: Any) {
        let budgetPopUp = BudgetPopUp()
        let popupView = budgetPopUp.createPopupview()
        
        let popupConfig = STZPopupViewConfig()
        popupConfig.dismissTouchBackground = true
        popupConfig.cornerRadius = 10
        popupConfig.showAnimation = .slideInFromTop
        popupConfig.dismissAnimation = .slideOutToTop
        popupConfig.showCompletion = { popupView in
            print("show")
        }
        popupConfig.dismissCompletion = { popupView in
            print("dismiss")
        }
        
        presentPopupView(popupView, config: popupConfig)
        
        
        print(Cart.shared.totalPrice())
    }
    
    //Segue when buttons are pressed
    @IBAction func AddManualButton(_ sender: Any) {
        self.performSegue(withIdentifier: ManualAddViewController.identifier, sender: nil)
    }
    
    @IBAction func AddCameraButton(_ sender: Any) {
        self.performSegue(withIdentifier: CameraViewController.identifier, sender: nil)
    }
    
    //Presents confirmation action sheet for clearing the cart when pressed
    @IBAction func NewListButton(_ sender: Any) {
        presentActionSheet()
        
    }
    
    //Present action sheet to confirm clearing list
    func presentActionSheet() {
        let actionSheetController = UIAlertController(title: "Confirm", message: "Are you sure you want to delete this list? This will also reset your budget?", preferredStyle: .actionSheet)
        
        let confirmAction = UIAlertAction(title: "Confirm", style: .default) { (action) in
            Cart.shared.removeAllItems()
            Budget.shared.budgetMax = nil
            self.update()
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .destructive, handler: nil)
        
        actionSheetController.addAction(confirmAction)
        actionSheetController.addAction(cancelAction)
        
        self.present(actionSheetController, animated: true, completion: nil)
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
