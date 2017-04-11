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
//class DrawCameraViewBorder {
//    
//    private var topBorder: UIView!
//    private var bottomBorder: UIView!
//    
//    
//    init(frame: CGRect) {
//        super.init(frame: frame)
//        drawBorders()
//    }
//
//    private func drawBorders() {
//        // adding a view
//        self.backgroundColor = UIColor.white
//        let bottomBorder = UIView(frame: CGRect(x: 0, y: 317, width: 375, height: 350))
//        self.addSubview(bottomBorder)
//        let topBorder = UIView(frame: CGRect(x: 0, y: 20, width: 375, height: 198))
//        self.addSubview(topBorder)
//        bottomBorder.backgroundColor = UIColor.white
//        topBorder.backgroundColor = UIColor.white
//        self.bottomBorder = bottomBorder
//        self.topBorder = topBorder
//        
////         self.backgroundColor = UIColor.white
////        topBorder.bounds = self.bounds
////        bottomBorder.bounds = self.bounds
////        bottomBorder = UIView(frame: CGRect(x: 0, y: 317, width: 375, height: 350))
////        topBorder = UIView(frame: CGRect(x: 0, y: 20, width: 375, height: 198))
//
////        self.addSubview(bottomBorder)
////        self.addSubview(topBorder)
////        
////        UIView.animate(withDuration: 0.6, delay: 0.0, options: .curveEaseOut, animations: {
////            self.bottomBorder.transform = CGAffineTransform(scaleX: 62.4, y: 62.4)
////        }, completion: nil)
//        
//        
//    }
//}
