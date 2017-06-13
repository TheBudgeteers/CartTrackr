//
//  AsynchronousCameraReading.swift
//  CartTrackr
//
//  Created by Jay Balderas on 6/13/17.
//  Copyright © 2017 Christina Lee. All rights reserved.
//

import UIKit
import AVFoundation
import SwiftyCam

protocol FrameDelegate: class {
    func captured(image: UIImage)
}

class AsynchronousCameraReading:  NSObject, AVCaptureVideoDataOutputSampleBufferDelegate {
//    var cameraView: CameraViewController! = nil
    

    private let sessionQueue = DispatchQueue(label: "session queue")
    private let position = AVCaptureDevicePosition.back
    private let quality = AVCaptureSessionPresetMedium
    private var permissionGranted = false
    private let captureSession = AVCaptureSession()
    private let context = CIContext()
    
    
     //required init is needed when using AVFoundation
    override init(){
        super .init()
        
        self.permissionGranted = true
        sessionQueue.async {
            self.configureSession()
            self.captureSession.startRunning()
        }
    }
     weak var delegate: FrameDelegate?
    
    
    private func configureSession() {
        guard permissionGranted else { return }
        captureSession.sessionPreset = quality
        guard let captureDevice = selectCaptureDevice() else { return }
        guard let captureDeviceInput = try? AVCaptureDeviceInput(device: captureDevice) else { return }
        guard captureSession.canAddInput(captureDeviceInput) else { return }
        captureSession.addInput(captureDeviceInput)
        let videoOutput = AVCaptureVideoDataOutput()
        videoOutput.setSampleBufferDelegate(self as AVCaptureVideoDataOutputSampleBufferDelegate, queue: DispatchQueue(label: "buffer images"))
        guard captureSession.canAddOutput(videoOutput) else { return }
        captureSession.addOutput(videoOutput)
        guard let connection = videoOutput.connection(withMediaType: AVFoundation.AVMediaTypeVideo) else { return }
        guard connection.isVideoOrientationSupported else { return }
        guard connection.isVideoMirroringSupported else { return }
        connection.videoOrientation = .portrait
     
    }
    
    private func selectCaptureDevice() -> AVCaptureDevice? {
        AVCaptureDeviceDiscoverySession(deviceTypes: [AVCaptureDeviceType.builtInDualCamera, AVCaptureDeviceType.builtInTelephotoCamera,AVCaptureDeviceType.builtInWideAngleCamera], mediaType: AVMediaTypeVideo, position: AVCaptureDevicePosition.back)
        for device in (deviceDiscoverySession?.devices)! {
            if(device.position == AVCaptureDevicePosition.back){
                return device
            }
        }
    }
    
    // MARK: Sample buffer to UIImage conversion
    private func imageFromSampleBuffer(sampleBuffer: CMSampleBuffer) -> UIImage? {
        guard let imageBuffer = CMSampleBufferGetImageBuffer(sampleBuffer) else { return nil }
        let ciImage = CIImage(cvPixelBuffer: imageBuffer)
        guard let cgImage = context.createCGImage(ciImage, from: ciImage.extent) else { return nil }
        return UIImage(cgImage: cgImage)
    }
    
    // MARK: AVCaptureVideoDataOutputSampleBufferDelegate
    func captureOutput(_ captureOutput: AVCaptureOutput!, didOutputSampleBuffer sampleBuffer: CMSampleBuffer!, from connection: AVCaptureConnection!) {
        print("Got a frame!")
        
//        guard let uiImage = imageFromSampleBuffer(sampleBuffer: sampleBuffer) else { return }
//        DispatchQueue.main.async { [unowned self] in
//            self.delegate?.captured(image: uiImage)
//        }
    }


}
