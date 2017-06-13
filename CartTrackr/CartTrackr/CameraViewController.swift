//
//  CameraViewController.swift
//  CartTrackr
//
//  Created by Christina Lee on 4/10/17.
//  Copyright © 2017 Christina Lee. All rights reserved.
//

import UIKit
import AVFoundation
import SwiftOCR
import Lottie

class CameraViewController: UIViewController, FrameDelegate {
    
    var asynchronousCameraReading: AsynchronousCameraReading!
    var previewLayer = AVCaptureVideoPreviewLayer();
    
    var flipCameraButton: UIButton!
    var flashButton: UIButton!
    var loadingAnimation: LOTAnimationView?
    
//    var priceString: String? {
//        didSet {
//            OperationQueue.main.addOperation {
////                self.performSegue(withIdentifier: ManualAddViewController.identifier, sender: nil)
//                self.dismiss(animated: true, completion: nil)
//                
//            }
//        }
//    }
    
    @IBOutlet weak var imagePreview: UIImageView!
    
    //required init is needed when using AVFoundation
//    required init?(coder aDecoder: NSCoder) {
//        super.init(coder: aDecoder)
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        asynchronousCameraReading = AsynchronousCameraReading()
        asynchronousCameraReading.delegate = self
        addButtons()
        
    }

    func captured(image: UIImage) {
        print("I wanna get this info\(image)")
        imagePreview.frame = self.view.frame
        imagePreview.image = image
    }
    
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    //Handles logic for segue to ManualAddViewController, passing price from OCR
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if segue.identifier == ManualAddViewController.identifier {
//            guard let destinationController = segue.destination as? ManualAddViewController else { return }
//            
//            print("inside segue prepare \(String(describing: self.priceString))")
//            destinationController.targetPrice = self.priceString
//            
//        }
//    }
    
    //Sends image to OCR, processes it and sets the priceString with the string that is returned
//    func swiftyCam(_ swiftyCam: SwiftyCamViewController, didTake photo: UIImage) {
//        
//        OCRProcess.shared.process(targetImage: photo, callback: { (priceString) in
//            self.priceString = priceString
//            print("camera controller\(String(describing: self.priceString))")
//            
//        })
//        
//    }

    
    //Calls function for swapping between front and rear cameras when pressed
    @objc private func cameraSwitchAction(_ sender: Any) {
        asynchronousCameraReading.flipCamera()
    }
    
//    Toggles the flash on the camera
    @objc private func toggleFlashAction(_ sender: Any) {
        asynchronousCameraReading.toggleFlash()
        
        if (asynchronousCameraReading.flash) {
            flashButton.setImage(#imageLiteral(resourceName: "flash"), for: UIControlState())
        } else {
            flashButton.setImage(#imageLiteral(resourceName: "flashOutline"), for: UIControlState())
        }
    }
    private func scanningAnimation(){
        
    }
    //Creates the buttons
    private func addButtons() {
        drawBorder()
        let cancelButton = UIButton(frame: CGRect(x: 10.0, y: 10.0, width: 30.0, height: 30.0))
        cancelButton.setImage(#imageLiteral(resourceName: "cancel-1"), for: UIControlState())
        cancelButton.addTarget(self, action: #selector(cancel), for: .touchUpInside)
        view.addSubview(cancelButton)
        
        
        loadingAnimation = LOTAnimationView(name: "search")
        loadingAnimation?.center = self.view.center
        loadingAnimation?.frame = self.view.bounds
        self.loadingAnimation?.contentMode = UIViewContentMode.scaleAspectFit
        self.view.addSubview(loadingAnimation!)
        loadingAnimation?.play(completion:nil)

        
//        loadingAnimation = CameraButtonView(frame: CGRect(x: view.frame.midX - 37.5, y: view.frame.height - 100.0, width: 75.0, height: 75.0))
        
//        self.view.addSubview(loadingAnimation)
        
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
        asynchronousCameraReading.stopSession()
        dismiss(animated: true, completion: nil)
    }
    
    //draws the border around the camera view, creating the box
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

