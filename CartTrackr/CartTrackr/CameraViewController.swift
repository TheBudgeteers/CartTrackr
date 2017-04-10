//
//  CameraViewController.swift
//  CartTrackr
//
//  Created by Christina Lee on 4/10/17.
//  Copyright © 2017 Christina Lee. All rights reserved.
//

import UIKit
import AVFoundation

class CameraViewController: UIViewController {

    //OUTLET for "previewView" goes here for UIView.
    //OUTLET for "captureImageView" goes here for UIImageView.
    //ACTION "didTakePhoto" goes here for take picture Button.
    
    var session: AVCaptureSession?
    var itemImageOutput: AVCapturePhotoOutput?
    var previewLayer: AVCaptureVideoPreviewLayer?
    
    //xcode linter made me write init like this below, AVFoundation thing???//////
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) is needed for NSCoder")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //Will only proceed if camera is authorizd through above function
        self.checkCameraAuthorization { authorized in
            if authorized {
                
                //prepares image for parsing(under 10mb parse max) normally "AVCaptureSessionPresetPhoto"
                self.session!.sessionPreset = AVCaptureSessionPresetMedium
                
                let rearCamera = AVCaptureDevice.defaultDevice(withMediaType: AVMediaTypeVideo)
                
                var error: NSError?
                var input: AVCaptureDeviceInput!
                
                do {
                    input = try AVCaptureDeviceInput(device: rearCamera)
                } catch let error1 as NSError {
                    error = error1
                    input = nil
                    print(error!.localizedDescription)
                }
                
                if error == nil && self.session!.canAddInput(input) {
                    //connects input for camera use
                    self.session!.addInput(input)
                    self.itemImageOutput = AVCapturePhotoOutput()
                    func capturePhoto() {
                        let previewPixelType = AVCapturePhotoSettings().availablePreviewPhotoPixelFormatTypes.first!
                        let previewFormat = [kCVPixelBufferPixelFormatTypeKey as String: previewPixelType,
                                             kCVPixelBufferWidthKey as String: 160,
                                             kCVPixelBufferHeightKey as String: 160]
                        AVCapturePhotoSettings().previewPhotoFormat = previewFormat
                        
                        self.itemImageOutput?.capturePhoto(with: AVCapturePhotoSettings(), delegate: self as! AVCapturePhotoCaptureDelegate)
                        
                    }
                   
                }
            } else {
                print("Permission to use camera denied.")
            }
        }
        
        
    }
    
    


}

