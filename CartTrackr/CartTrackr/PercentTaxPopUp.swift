//
//  PercentTaxPopUp.swift
//  CartTrackr
//
//  Created by Rio Balderas on 6/14/17.
//  Copyright © 2017 Christina Lee. All rights reserved.
//

import UIKit

class PercentTax: UIView {

    func createPopupview() -> UIView {
        let cart = CartViewController()
        
        //you can change the size of pop up here
        let popupView = UIView(frame: CGRect(x: 0, y: 0, width: 350, height: 300))
        popupView.backgroundColor = UIColor.white
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: PercentTax(), action: #selector(UIInputViewController.dismissKeyboard))
        popupView.addGestureRecognizer(tap)
        
        
        let viewWidth = popupView.frame.size.width
        let viewHeight = popupView.frame.size.height
        
        
        let textField = UITextField(frame: CGRect(x: viewWidth/7, y: viewHeight/4, width: viewWidth-100
            , height: 60.0))
        textField.placeholder = "%\(String(describing: Cart.shared.currentTaxRate!))"
        textField.font = UIFont.systemFont(ofSize: 50)
        textField.borderStyle = UITextBorderStyle.roundedRect
        textField.autocorrectionType = UITextAutocorrectionType.yes
        textField.keyboardType = UIKeyboardType.decimalPad
        textField.returnKeyType = UIReturnKeyType.done
        textField.clearButtonMode = UITextFieldViewMode.whileEditing;
        textField.addTarget(self, action: #selector(cart.textFieldDidChange2(_:)), for: .editingChanged)
        textField.contentVerticalAlignment = UIControlContentVerticalAlignment.center
        textField.delegate = self as? UITextFieldDelegate
        popupView.addSubview(textField)
        
        let taxText: UILabel = UILabel()
        taxText.frame = CGRect(x: 0, y: viewHeight/20, width: viewWidth, height: 30)
        taxText.textAlignment = .center
        taxText.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 35.0)
        let mainBlueColor = cart.hexStringToUIColor(hex: "#044389")
        taxText.textColor = mainBlueColor
        taxText.numberOfLines = 1
        taxText.text = "Set Tax Rate"
        
        popupView.addSubview(taxText)
        
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
