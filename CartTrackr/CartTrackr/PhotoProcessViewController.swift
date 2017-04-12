////
////  PhotoProcessViewController.swift
////  CartTrackr
////
////  Created by Rio Balderas on 4/10/17.
////  Copyright © 2017 Christina Lee. All rights reserved.
////
//
//import UIKit
//import SwiftyCam
//import SwiftOCR
//
//class PhotoProcessViewController: UIViewController {
//    let OCR = SwiftOCR()
//
//    override var prefersStatusBarHidden: Bool {
//        return true
//    }
//    
//    private var backgroundImage: UIImage
//    
//    init(image: UIImage) {
//        self.backgroundImage = image
//        super.init(nibName: nil, bundle: nil)
//    }
//    
//    required init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        
//        let cropped = prepareImageForCrop(using: self.backgroundImage)
//        var priceString : String = ""
//        self.OCR.recognize(cropped) { (recognizedString) in
//            print(recognizedString)
//            guard let dollars = recognizedString.components(separatedBy: "I").first?.components(separatedBy: "S").last else { return }
//            guard let cents = recognizedString.components(separatedBy: "I").last else { return }
//            priceString = "\(String(describing: dollars)).\(String(describing: cents))"
//            print(priceString)
//        }
//        
////        func process(targetImage: UIImage) -> String {
////            let cropped = prepareImageForCrop(using: targetImage)
////            var priceString : String = ""
////            OCR.recognize(cropped) { (recognizedString) in
////                print(recognizedString)
////
////                let dollars = recognizedString.components(separatedBy: "I").first
////                let cents = recognizedString.components(separatedBy: "I").last
////                priceString = "\(String(describing: dollars)).\(String(describing: cents))"
////                print(priceString)
////            }
////            
////            return priceString
////        }
//        
////Look at viewController in SwiftOCR line 155 to configure this below...
//        self.view.backgroundColor = UIColor.gray
//        
//        let backgroundImageView = UIImageView(frame: view.frame)
//        backgroundImageView.contentMode = UIViewContentMode.scaleAspectFit
//        backgroundImageView.image = backgroundImage
//        view.addSubview(backgroundImageView)
//        
//        //This is same exit button used in CameraViewController to dismiss
//        let cancelButton = UIButton(frame: CGRect(x: 10.0, y: 10.0, width: 30.0, height: 30.0))
//        cancelButton.setImage(#imageLiteral(resourceName: "cancel"), for: UIControlState())
//        cancelButton.addTarget(self, action: #selector(cancel), for: .touchUpInside)
//        view.addSubview(cancelButton)
//    }
//    
//    func cancel() {
//        dismiss(animated: true, completion: nil)
//    }
//
//    func prepareImageForCrop (using image: UIImage) -> UIImage {
//        let degreesToRadians: (CGFloat) -> CGFloat = {
//            return $0 / 180.0 * CGFloat(Float.pi)
//        }
//        
//        let imageOrientation = image.imageOrientation
//        let degree = image.detectOrientationDegree()
//        let cropSize = CGSize(width: 400, height: 110)
//        
//        //Downscale
//        let cgImage = image.cgImage!
//        
//        let width = cropSize.width
//        let height = image.size.height / image.size.width * cropSize.width
//        
//        let bitsPerComponent = cgImage.bitsPerComponent
//        let bytesPerRow = cgImage.bytesPerRow
//        let colorSpace = cgImage.colorSpace
//        let bitmapInfo = cgImage.bitmapInfo
//        
//        let context = CGContext(data: nil,
//                                width: Int(width),
//                                height: Int(height),
//                                bitsPerComponent: bitsPerComponent,
//                                bytesPerRow: bytesPerRow,
//                                space: colorSpace!,
//                                bitmapInfo: bitmapInfo.rawValue)
//        
//        context!.interpolationQuality = CGInterpolationQuality.none
//        // Rotate the image context
//        context?.rotate(by: degreesToRadians(degree));
//        // Now, draw the rotated/scaled image into the context
//        context?.scaleBy(x: -1.0, y: -1.0)
//        
//        //Crop
//        switch imageOrientation {
//        case .right, .rightMirrored:
//            context?.draw(cgImage, in: CGRect(x: -height, y: 0, width: height, height: width))
//        case .left, .leftMirrored:
//            context?.draw(cgImage, in: CGRect(x: 0, y: -width, width: height, height: width))
//        case .up, .upMirrored:
//            context?.draw(cgImage, in: CGRect(x: 0, y: 0, width: width, height: height))
//        case .down, .downMirrored:
//            context?.draw(cgImage, in: CGRect(x: -width, y: -height, width: width, height: height))
//        }
//        
//        let calculatedFrame = CGRect(x: 0, y: CGFloat((height - cropSize.height)/2.0), width: cropSize.width, height: cropSize.height)
//        let scaledCGImage = context?.makeImage()?.cropping(to: calculatedFrame)
//        
//        
//        return UIImage(cgImage: scaledCGImage!)
//    }
//    
//
//}
//
////MARK: UIImage
//extension UIImage {
//    func detectOrientationDegree () -> CGFloat {
//        switch imageOrientation {
//        case .right, .rightMirrored:    return 90
//        case .left, .leftMirrored:      return -90
//        case .up, .upMirrored:          return 180
//        case .down, .downMirrored:      return 0
//        }
//    }
//}
