//
//  CameraViewController.swift
//  CartTrackr
//
//  Created by Christina Lee on 4/10/17.
//  Copyright © 2017 Christina Lee. All rights reserved.
//

import UIKit
import AVFoundation
import Lottie

class CameraViewController: UIViewController, FrameDelegate, UITextFieldDelegate {
    
    var asynchronousCameraReading: AsynchronousCameraReading!
    var previewLayer = AVCaptureVideoPreviewLayer();
    
    var flipCameraButton: UIButton!
    var flashButton: UIButton!
    var loadingAnimation: LOTAnimationView?
    var labelOutput: String!
    var readingLabel: UILabel! = nil
    var itemDescription: String! = "Item"
    
    private let sessionQueue = DispatchQueue(label: "OCR queue")
    
    var priceString: String! = nil
    {
        didSet {
            var valid:String! = nil
           valid = priceString.readingValidate(reading: priceString!)
            if (valid != "notValid"){
                 OCRPriceString.shared.priceString = valid
                            OperationQueue.main.addOperation {
                                self.asynchronousCameraReading.stopSession()
                                self.asynchronousCameraReading.sessionQueue.suspend()
                                self.confirmPopup()
                            }
            }
            
//            OperationQueue.main.addOperation {
//            }
            //            OperationQueue.main.cancelAllOperations()
            
            //            OperationQueue.main.addOperation {
            //                self.performSegue(withIdentifier: ManualAddViewController.identifier, sender: nil)
            //                self.dismiss(animated: true, completion: nil)
            //                if (self.readingLabel != nil){
            //                self.readingLabel.removeFromSuperview()
            //                }
            //                self.scanningLabel()
            print("=----------\(String(describing: self.priceString!))---------------")
            
            //            }
        }
    }
    
    @IBOutlet weak var imagePreview: UIImageView!
    
//    required init is needed when using AVFoundation
//    required init?(coder aDecoder: NSCoder) {
//        super.init(coder: aDecoder)
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        asynchronousCameraReading = AsynchronousCameraReading()
        asynchronousCameraReading.delegate = self
        addButtons()
        addLoadingGestureRecognizer()
        
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool
    {
        textField.resignFirstResponder()
        return true
    }
    
    func price(price: String){
        if(price != ""){
            
            
           self.priceString = price
            
          
        }

    }
    
    func captured(image: UIImage) {
        print("------------------------------------")
        self.imagePreview.frame = self.view.frame
        self.imagePreview.image = image
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
//       
//        
//    }
    func textFieldDidChange(_ textField: UITextField){
//        userBudgetSet = textField.text!
    }
    
    func textFieldDidChange2(_ textField: UITextField){
                OCRPriceString.shared.priceString = textField.text!
    }
    
    func dismissKeyboard(){
        view.endEditing(true)
    }
    
    func touchCancel() {
        dismissPopupView()
        asynchronousCameraReading.startSession()
    }
    
    func touchClose() {
//        Budget.shared.budgetMax = userBudgetSet
        dismissPopupView()
        Cart.shared.addItem(OCRPriceString.shared.priceString, itemDescription, "1")
        asynchronousCameraReading.stopSession()
        self.asynchronousCameraReading.sessionQueue.suspend()
        self.dismiss(animated: true) {
            CartViewController().update()
        }
    }
    
    //Calls function for swapping between front and rear cameras when pressed
    @objc private func cameraSwitchAction(_ sender: Any) {
        asynchronousCameraReading.flipCamera()
    }
    @objc private func startSession(_ sender: Any) {
        asynchronousCameraReading.startSession()
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
    
    private func confirmPopup(){
        let confirm = ConfirmView()
        let popupView = confirm.createPopupview()
        
        let popupConfig = STZPopupViewConfig()
        popupConfig.dismissTouchBackground = true
        popupConfig.cornerRadius = 10
        popupConfig.showAnimation = .slideInFromBottom
        popupConfig.dismissAnimation = .slideOutToTop
        popupConfig.showCompletion = { popupView in
            print("show")
        }
        popupConfig.dismissCompletion = { popupView in
            print("dismiss")
        }
        
        presentPopupView2(popupView, config: popupConfig)

    }
    func switchChanged(sender: UISwitch!) {
        var decimalChange = OCRPriceString.shared.priceString
        if (sender.isOn){
            decimalChange = decimalChange?.fullDollarValue(dollar: decimalChange!)
        } else {
        decimalChange = decimalChange?.decimalValue(dollar: decimalChange!)
        }
        OCRPriceString.shared.priceString = decimalChange!
        OperationQueue.main.addOperation {
            self.dismissPopupView()
        }
        OperationQueue.main.addOperation {
            self.confirmPopup()
        
        }
//        OperationQueue.defaultMaxConcurrentOperationCount = 1
    }
    
    
    
    private func addLoadingGestureRecognizer(){
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(startSession(_:)))
            
        tapRecognizer.numberOfTapsRequired = 1
        loadingAnimation?.addGestureRecognizer(tapRecognizer)
    }
    //Creates the buttons
    private func addButtons() {
        drawBorder()
        let viewWidth = self.view.frame.size.width
        let viewHeight = self.view.frame.size.height
        
        let cancelButton = UIButton(frame: CGRect(x: 10.0, y: 10.0, width: 30.0, height: 30.0))
        cancelButton.setImage(#imageLiteral(resourceName: "cancel-1"), for: UIControlState())
        cancelButton.addTarget(self, action: #selector(cancel), for: .touchUpInside)
        view.addSubview(cancelButton)
        
        let cameraLabel = UILabel(frame: CGRect(x: 0, y: viewHeight/2-200, width: viewWidth, height: 30))
        cameraLabel.textAlignment = .center
        cameraLabel.text = "Fit price in box below!"
        cameraLabel.textColor = .white
        cameraLabel.font = UIFont(name: "HelveticaNeue", size: 20)
        self.view.addSubview(cameraLabel)

            
        loadingAnimation = LOTAnimationView(name: "search")
        loadingAnimation?.frame = CGRect(x: viewWidth/2-70, y: viewHeight-viewHeight/3, width: 140, height: 140)
        self.loadingAnimation?.contentMode = UIViewContentMode.scaleAspectFit
        loadingAnimation?.isUserInteractionEnabled = true
        self.view.addSubview(loadingAnimation!)
        loadingAnimation?.loopAnimation = true
        loadingAnimation?.play()

        

        
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

