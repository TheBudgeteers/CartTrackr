////
////  CameraViewDrawBorder.swift
////  CartTrackr
////
////  Created by Rio Balderas on 4/10/17.
////  Copyright © 2017 Christina Lee. All rights reserved.
////
//
//import UIKit
//import SwiftyCam
//
//class DrawCameraViewBorder: SwiftyCamButton {
//    
//    private var topBorder: UIView!
//    private var bottomBorder: UIView!
//    
//    
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//        drawBorders()
//    }
//    
//    required init?(coder aDecoder: NSCoder) {
//        super.init(coder: aDecoder)
//        drawBorders()
//    }
//    private func drawBorders() {
//         self.backgroundColor = UIColor.white
//        topBorder.bounds = self.bounds
//        bottomBorder.bounds = self.bounds
//        bottomBorder = UIView(frame: CGRect(x: 0, y: 317, width: 375, height: 350))
//        topBorder = UIView(frame: CGRect(x: 0, y: 20, width: 375, height: 198))
//        bottomBorder.backgroundColor = UIColor.white
//        topBorder.backgroundColor = UIColor.white
//        self.addSubview(bottomBorder)
//        self.addSubview(topBorder)
//        
//        UIView.animate(withDuration: 0.6, delay: 0.0, options: .curveEaseOut, animations: {
//            self.bottomBorder.transform = CGAffineTransform(scaleX: 62.4, y: 62.4)
//        }, completion: nil)
//        
//        
//    }
//}
