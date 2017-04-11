//
//  CameraViewController.swift
//  CartTrackr
//
//  Created by Christina Lee on 4/10/17.
//  Copyright © 2017 Christina Lee. All rights reserved.
//

import UIKit
import AVFoundation
import SwiftyCam
import SwiftOCR


class CameraViewController: SwiftyCamViewController {

    
    var flipCameraButton: UIButton!
    var flashButton: UIButton!
    var captureButton: CameraButtonView!
    
    @IBOutlet weak var cameraViewTopBorder: UIView!
    @IBOutlet weak var cameraViewBottomBorder: UIView!
    
    //required init is needed when using AVFoundation
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        cameraDelegate = self
        shouldUseDeviceOrientation = true
        
        addButtons()

    }
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    func swiftyCam(_ swiftyCam: SwiftyCamViewController, didTake photo: UIImage) {

        let newVC = PhotoProcessViewController(image: photo)
        
        self.present(newVC, animated: true, completion: nil)
    }
    
    func swiftyCam(_ swiftyCam: SwiftyCamViewController, didFocusAtPoint point: CGPoint) {
        let focusView = UIImageView(image: #imageLiteral(resourceName: "focus"))
        focusView.center = point
        focusView.alpha = 0.0
        view.addSubview(focusView)
        
        UIView.animate(withDuration: 0.25, delay: 0.0, options: .curveEaseInOut, animations: {
            focusView.alpha = 1.0
            focusView.transform = CGAffineTransform(scaleX: 1.25, y: 1.25)
        }, completion: { (success) in
            UIView.animate(withDuration: 0.15, delay: 0.5, options: .curveEaseInOut, animations: {
                focusView.alpha = 0.0
                focusView.transform = CGAffineTransform(translationX: 0.6, y: 0.6)
            }, completion: { (success) in
                focusView.removeFromSuperview()
            })
        })
    }
    
    func swiftyCam(_ swiftyCam: SwiftyCamViewController, didChangeZoomLevel zoom: CGFloat) {
        print(zoom)
    }
    
    func swiftyCam(_ swiftyCam: SwiftyCamViewController, didSwitchCameras camera: SwiftyCamViewController.CameraSelection) {
        print(camera)
    }

    
    //Checker used to check authorization of using camera
    func checkCameraAuthorization(_ completionHandler: @escaping((_ authorized: Bool)-> Void)){
        switch AVCaptureDevice.authorizationStatus(forMediaType: AVMediaTypeVideo){
        
        case .denied:
            completionHandler(false)
        case .authorized:
            completionHandler(true)
        case .notDetermined:
            AVCaptureDevice.requestAccess(forMediaType: AVMediaTypeVideo, completionHandler: { success in
                completionHandler(success)
            })
        case .restricted:
            completionHandler(false)
        }
    }
    
    @objc private func cameraSwitchAction(_ sender: Any) {
        switchCamera()
    }
    
    @objc private func toggleFlashAction(_ sender: Any) {
        flashEnabled = !flashEnabled
        
        if flashEnabled == true {
            flashButton.setImage(#imageLiteral(resourceName: "flash"), for: UIControlState())
        } else {
            flashButton.setImage(#imageLiteral(resourceName: "flashOutline"), for: UIControlState())
        }
    }
    
    private func addButtons() {
        drawBorder()
        let cancelButton = UIButton(frame: CGRect(x: 10.0, y: 10.0, width: 30.0, height: 30.0))
        cancelButton.setImage(#imageLiteral(resourceName: "cancel"), for: UIControlState())
        cancelButton.addTarget(self, action: #selector(cancel), for: .touchUpInside)
        view.addSubview(cancelButton)
        
        captureButton = CameraButtonView(frame: CGRect(x: view.frame.midX - 37.5, y: view.frame.height - 100.0, width: 75.0, height: 75.0))
        captureButton.setImage(#imageLiteral(resourceName: "cartPic"), for: UIControlState())
        
        self.view.addSubview(captureButton)
        
        captureButton.delegate = self
        
        flipCameraButton = UIButton(frame: CGRect(x: (((view.frame.width / 2 - 37.5) / 2) - 15.0), y: view.frame.height - 74.0, width: 30.0, height: 23.0))
        flipCameraButton.setImage(#imageLiteral(resourceName: "flipCamera"), for: UIControlState())
        flipCameraButton.addTarget(self, action: #selector(cameraSwitchAction(_:)), for: .touchUpInside)
        self.view.addSubview(flipCameraButton)
        
        let test = CGFloat((view.frame.width - (view.frame.width / 2 + 37.5)) + ((view.frame.width / 2) - 37.5) - 9.0)
        
        flashButton = UIButton(frame: CGRect(x: test, y: view.frame.height - 77.5, width: 18.0, height: 30.0))
        flashButton.setImage(#imageLiteral(resourceName: "flashOutline"), for: UIControlState())
        flashButton.addTarget(self, action: #selector(toggleFlashAction(_:)), for: .touchUpInside)
        self.view.addSubview(flashButton)
    }
    
    func cancel() {
        dismiss(animated: true, completion: nil)
    }
    
    func drawBorder() {
        let viewWidth = self.view.frame.size.width
        let viewHeight = self.view.frame.size.height
        
        let topBorder = UIView()
        let bottomBorder = UIView()
        let leftBorder = UIView()
        let rightBorder = UIView()
        
        print("view width: \(viewWidth)")
        print("view height: \(viewHeight)")

        topBorder.frame = CGRect(x: 0, y: 0, width: viewWidth, height: viewHeight/2 - 50)
        bottomBorder.frame = CGRect(x: 0, y: viewHeight/2 + 50, width: viewWidth, height: viewHeight/2 - 50)
        leftBorder.frame = CGRect(x: 0, y: viewHeight/2 - 50, width: 35, height: 100)
        rightBorder.frame = CGRect(x: viewWidth-35, y: viewHeight/2 - 50, width: 35, height: 100)

        topBorder.backgroundColor = UIColor(white: 0.2, alpha: 0.8)
        bottomBorder.backgroundColor = UIColor(white: 0.2, alpha: 0.8)
        leftBorder.backgroundColor = UIColor(white: 0.2, alpha: 0.8)
        rightBorder.backgroundColor = UIColor(white: 0.2, alpha: 0.8)

        self.view.addSubview(topBorder)
        self.view.addSubview(bottomBorder)
        self.view.addSubview(leftBorder)
        self.view.addSubview(rightBorder)

    }

}

extension CameraViewController: SwiftyCamViewControllerDelegate{
    
    

}

