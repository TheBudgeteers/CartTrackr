//
//  ConfirmView.swift
//  CartTrackr
//
//  Created by Jay Balderas on 6/14/17.
//  Copyright © 2017 Christina Lee. All rights reserved.
//

import UIKit

class ConfirmView: UIView,UITextFieldDelegate{
    //MARK: BudgetPop Up function to add in logic etc
    func createPopupview() -> UIView {
        let cart = CartViewController()
        let camera = CameraViewController()
        
        //you can change the size of pop up here
        let popupView = UIView(frame: CGRect(x: 0, y: 0, width: camera.view.frame.width, height: 300))
        popupView.backgroundColor = UIColor.white
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: ConfirmView(), action: #selector(UIInputViewController.dismissKeyboard))
        popupView.addGestureRecognizer(tap)
        
        
        let viewWidth = popupView.frame.size.width
        let viewHeight = popupView.frame.size.height
        
        
        let textField = UITextField(frame: CGRect(x: viewWidth/2-(viewWidth-100)/2, y: viewHeight/8, width: viewWidth-100
            , height: 60.0))
        textField.placeholder = "\("Description")"
        textField.becomeFirstResponder()
        textField.font = UIFont.systemFont(ofSize: 30)
        textField.borderStyle = UITextBorderStyle.roundedRect
        textField.autocorrectionType = UITextAutocorrectionType.yes
        textField.keyboardType = UIKeyboardType.alphabet
        textField.returnKeyType = UIReturnKeyType.done
        textField.clearButtonMode = UITextFieldViewMode.whileEditing;
        textField.addTarget(self, action: #selector(camera.textFieldDidChange(_:)), for: .editingChanged)
        textField.contentVerticalAlignment = UIControlContentVerticalAlignment.center
        textField.delegate = self
        textField.returnKeyType = .default
        popupView.addSubview(textField)
        
        let textField2 = UITextField(frame: CGRect(x: viewWidth/2-(viewWidth-100)/2, y: viewHeight/8+68, width: viewWidth-100
            , height: 60.0))
        
//        DispatchQueue.main.async(execute: {
            textField2.text = "\(String(describing: OCRPriceString.shared.priceString!))"
//            });
        
        textField2.font = UIFont.systemFont(ofSize: 50)
        textField2.borderStyle = UITextBorderStyle.roundedRect
        textField2.autocorrectionType = UITextAutocorrectionType.yes
        textField2.keyboardType = UIKeyboardType.decimalPad
        textField2.returnKeyType = UIReturnKeyType.done
        textField2.clearButtonMode = UITextFieldViewMode.whileEditing;
        textField2.addTarget(self, action: #selector(camera.textFieldDidChange2(_:)), for: .editingChanged)
        textField2.contentVerticalAlignment = UIControlContentVerticalAlignment.center
        textField2.delegate = self
        popupView.addSubview(textField2)
        
//////////////Will add later for toggle from full dollar to decimal.
        
        
//        let mySwitch = UISwitch(frame: CGRect(x: viewWidth/2-(viewWidth-100)/2, y: viewHeight-viewHeight/3, width: 100, height: 50))
////        mySwitch.center = popupView.center
//        mySwitch.setOn(false, animated: true)
//        mySwitch.tintColor = UIColor.blue
//        mySwitch.onTintColor = UIColor.green
//        mySwitch.thumbTintColor = UIColor.darkGray
//        mySwitch.addTarget(self, action: #selector(camera.switchChanged(sender:)), for: UIControlEvents.valueChanged)
//        
////        mySwitch.addTarget(self, action: #selector(camera.switchChanged(_:)), for: UIControlEvents.ValueChanged)
//        
//        popupView.addSubview(mySwitch)
//        
//        let fullDollarLabel: UILabel = UILabel()
//        fullDollarLabel.frame = CGRect(x: viewWidth/4+8, y: viewHeight-viewHeight/3, width: viewWidth/2, height: 30)
//        fullDollarLabel.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 35.0)
//        let mainBlueColor = cart.hexStringToUIColor(hex: "#044389")
//        fullDollarLabel.textColor = mainBlueColor
//        fullDollarLabel.backgroundColor = UIColor.white
//        fullDollarLabel.numberOfLines = 1
//        fullDollarLabel.text = "1$"
//        
//        popupView.addSubview(fullDollarLabel)
        
        //Draws close button on the pop up
        let cancelButton = UIButton(frame: CGRect(x: viewWidth/2, y: viewHeight-viewHeight/3-12, width: 50, height: 50))
        cancelButton.setImage(#imageLiteral(resourceName: "cancel-1"), for: UIControlState())
        cancelButton.addTarget(self, action: #selector(camera.touchCancel), for: UIControlEvents.touchUpInside)
        popupView.addSubview(cancelButton)
        
        //Draws Add To Cart button
        let done = UIButton(frame: CGRect(x: viewWidth-110, y: viewHeight-viewHeight/3-20, width: 60
            , height: 60))
        done.setImage(#imageLiteral(resourceName: "cartPic"), for: .normal)
        done.addTarget(self, action: #selector(camera.touchClose), for: UIControlEvents.touchUpInside)
        popupView.addSubview(done)
        
        return popupView
        
    }

    
    
}
