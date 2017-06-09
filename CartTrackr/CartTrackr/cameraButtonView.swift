//
//  cameraButtonView.swift
//  CartTrackr
//
//  Created by Jay Balderas on 4/10/17.
//  Copyright © 2017 Christina Lee. All rights reserved.
//

import UIKit
import SwiftyCam

class CameraButtonView: SwiftyCamButton {
    
    private var cartPicImage: CALayer!
    private var cartPicEnlarge: UIView!
    let cartPic = UIImage(named: "Camera_Icon")?.cgImage
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        drawButton()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        drawButton()
    }
    
    private func drawButton() {
        self.backgroundColor = UIColor.clear
        cartPicImage = CALayer()
        cartPicImage.backgroundColor = UIColor.clear.cgColor
        cartPicImage.contents = cartPic
        cartPicImage.borderWidth = 0.0
        cartPicImage.bounds = self.bounds
        cartPicImage.position = CGPoint(x: self.bounds.midX, y: self.bounds.midY)
        cartPicImage.cornerRadius = self.frame.size.width / 2
        layer.insertSublayer(cartPicImage, at: 0)
        
    }
   
}
