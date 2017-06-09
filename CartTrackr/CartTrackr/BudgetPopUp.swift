//
//  BudgetPopUp.swift
//  CartTrackr
//
//  Created by Jay Balderas on 6/9/17.
//  Copyright © 2017 Christina Lee. All rights reserved.
//

import UIKit

class BudgetPopUp: UIView{
    
    //MARK: BudgetPop Up function to add in logic etc
    func createPopupview() -> UIView {
        let cart = CartViewController()
        
        //you can change the size of pop up here
        let popupView = UIView(frame: CGRect(x: 0, y: 0, width: 350, height: 300))
        popupView.backgroundColor = UIColor.white
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: BudgetPopUp(), action: #selector(UIInputViewController.dismissKeyboard))
        popupView.addGestureRecognizer(tap)
        
        
        let viewWidth = popupView.frame.size.width
        let viewHeight = popupView.frame.size.height
        
        
        let textField = UITextField(frame: CGRect(x: viewWidth/7, y: viewHeight/4, width: viewWidth-100
            , height: 60.0))
        textField.placeholder = "\(Budget.shared.budgetMax ?? "0.00")"
        textField.font = UIFont.systemFont(ofSize: 50)
        textField.borderStyle = UITextBorderStyle.roundedRect
        textField.autocorrectionType = UITextAutocorrectionType.yes
        textField.keyboardType = UIKeyboardType.decimalPad
        textField.returnKeyType = UIReturnKeyType.done
        textField.clearButtonMode = UITextFieldViewMode.whileEditing;
        textField.addTarget(self, action: #selector(cart.textFieldDidChange(_:)), for: .editingChanged)
        textField.contentVerticalAlignment = UIControlContentVerticalAlignment.center
        textField.delegate = self as? UITextFieldDelegate
        popupView.addSubview(textField)
        
        let budgetText: UILabel = UILabel()
        budgetText.frame = CGRect(x: viewWidth/4, y: viewHeight/20, width: viewWidth/2, height: 30)
        budgetText.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 35.0)
        let mainBlueColor = cart.hexStringToUIColor(hex: "#044389")
        budgetText.textColor = mainBlueColor
        budgetText.backgroundColor = UIColor.white
        budgetText.numberOfLines = 1
        budgetText.text = "Set Budget"
        
        popupView.addSubview(budgetText)
        
        //Draws close button on the pop up
        let cancelButton = UIButton(frame: CGRect(x: 10.0, y: 10.0, width: 30.0, height: 30.0))
        cancelButton.setImage(#imageLiteral(resourceName: "cancel-1"), for: UIControlState())
        cancelButton.addTarget(self, action: #selector(cart.touchCancel), for: UIControlEvents.touchUpInside)
        popupView.addSubview(cancelButton)
        
        //Draws Done button
        let done = UIButton(frame: CGRect(x: viewWidth/7, y: viewHeight/2, width: viewWidth-100
            , height: 60.0))
        let customGreen = cart.hexStringToUIColor(hex: "#53b44c")
        done.backgroundColor = customGreen
        done.layer.cornerRadius = 8
        done.setTitle("Done", for: .normal)
        done.setTitleColor(UIColor.white, for: .normal)
        
        done.addTarget(self, action: #selector(cart.touchClose), for: UIControlEvents.touchUpInside)
        popupView.addSubview(done)
        
        return popupView
        
    }
    
    
}
