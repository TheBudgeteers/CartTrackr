//
//  ConfirmView.swift
//  CartTrackr
//
//  Created by Jay Balderas on 6/14/17.
//  Copyright © 2017 Christina Lee. All rights reserved.
//

import UIKit

class ConfirmView: UIView{
    
    //MARK: BudgetPop Up function to add in logic etc
    func createPopupview() -> UIView {
        let cart = CartViewController()
        let camera = CameraViewController()
        
        //you can change the size of pop up here
        let popupView = UIView(frame: CGRect(x: -self.frame.height/2, y: 0, width: 350, height: 300))
        popupView.backgroundColor = UIColor.white
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: ConfirmView(), action: #selector(UIInputViewController.dismissKeyboard))
        popupView.addGestureRecognizer(tap)
        
        
        let viewWidth = popupView.frame.size.width
        let viewHeight = popupView.frame.size.height
        
        
        let textField = UITextField(frame: CGRect(x: viewWidth/7, y: viewHeight/8, width: viewWidth-100
            , height: 60.0))
        textField.placeholder = "\("Description")"
        textField.font = UIFont.systemFont(ofSize: 50)
        textField.borderStyle = UITextBorderStyle.roundedRect
        textField.autocorrectionType = UITextAutocorrectionType.yes
        textField.keyboardType = UIKeyboardType.decimalPad
        textField.returnKeyType = UIReturnKeyType.done
        textField.clearButtonMode = UITextFieldViewMode.whileEditing;
        textField.addTarget(self, action: #selector(camera.textFieldDidChange(_:)), for: .editingChanged)
        textField.contentVerticalAlignment = UIControlContentVerticalAlignment.center
        textField.delegate = self as? UITextFieldDelegate
        popupView.addSubview(textField)
        
        let textField2 = UITextField(frame: CGRect(x: viewWidth/7, y: viewHeight/8+68, width: viewWidth-100
            , height: 60.0))
        textField2.text = "\(String(describing: OCRPriceString.shared.priceString!))"
        textField2.font = UIFont.systemFont(ofSize: 50)
        textField2.borderStyle = UITextBorderStyle.roundedRect
        textField2.autocorrectionType = UITextAutocorrectionType.yes
        textField2.keyboardType = UIKeyboardType.decimalPad
        textField2.returnKeyType = UIReturnKeyType.done
        textField2.clearButtonMode = UITextFieldViewMode.whileEditing;
        textField2.addTarget(self, action: #selector(camera.textFieldDidChange2(_:)), for: .editingChanged)
        textField2.contentVerticalAlignment = UIControlContentVerticalAlignment.center
        textField2.delegate = self as? UITextFieldDelegate
        popupView.addSubview(textField2)
        
//        let descriptionLabel: UILabel = UILabel()
//        descriptionLabel.frame = CGRect(x: viewWidth/4, y: viewHeight/20, width: viewWidth/2, height: 30)
//        descriptionLabel.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 35.0)
//        let mainBlueColor = cart.hexStringToUIColor(hex: "#044389")
//        descriptionLabel.textColor = mainBlueColor
//        descriptionLabel.backgroundColor = UIColor.white
//        descriptionLabel.numberOfLines = 1
//        descriptionLabel.text = "Description"
//        
//        popupView.addSubview(descriptionLabel)
        
        //Draws close button on the pop up
        let cancelButton = UIButton(frame: CGRect(x: 10.0, y: 10.0, width: 30.0, height: 30.0))
        cancelButton.setImage(#imageLiteral(resourceName: "cancel-1"), for: UIControlState())
        cancelButton.addTarget(self, action: #selector(camera.touchCancel), for: UIControlEvents.touchUpInside)
        popupView.addSubview(cancelButton)
        
        //Draws Done button
        let done = UIButton(frame: CGRect(x: viewWidth/7, y: viewHeight-viewHeight/4, width: viewWidth-100
            , height: 60.0))
        let customGreen = cart.hexStringToUIColor(hex: "#53b44c")
        done.backgroundColor = customGreen
        done.layer.cornerRadius = 8
        done.setTitle("Done", for: .normal)
        done.setTitleColor(UIColor.white, for: .normal)
        
        done.addTarget(self, action: #selector(camera.touchClose), for: UIControlEvents.touchUpInside)
        popupView.addSubview(done)
        
        return popupView
        
    }
    
    
}
