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

    //OUTLET for "previewView" goes here for UIView
    //OUTLET for "captureImageView" goes here for UIImageView
    //ACTION "didTakePhoto" goes here for take picture Button
    
    var session: AVCaptureSession?
    var priceImageOutput: AVCapturePhotoOutput?
    var previewLayer: AVCaptureVideoPreviewLayer?
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }



}

