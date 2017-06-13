//
//  AsynchronousCameraReading.swift
//  CartTrackr
//
//  Created by Jay Balderas on 6/13/17.
//  Copyright © 2017 Christina Lee. All rights reserved.
//

import UIKit
import AVFoundation

protocol FrameDelegate: class {
    func captured(image: UIImage)
}

class AsynchronousCameraReading: CameraViewController {

    private let sessionQueue = DispatchQueue(label: "session queue")
    
     weak var delegate: FrameDelegate?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }


}
