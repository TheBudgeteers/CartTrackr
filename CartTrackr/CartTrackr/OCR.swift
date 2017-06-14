//
//  OCR.swift
//  CartTrackr
//
//  Created by Christina Lee on 4/10/17.
//  Copyright © 2017 Christina Lee. All rights reserved.
//

import UIKit
import SwiftOCR

typealias OCRCallback = (String) -> ()


class OCRProcess {
    let OCR = SwiftOCR()
    
    static let shared = OCRProcess()
    
    private init() {}
    
    //Sends the cropped image to the OCR and formats the string that is returned
    func process(targetImage: UIImage, callback: @escaping OCRCallback )   {
        let cropped = prepareImageForCrop(using: targetImage)
        var priceString : String = ""
        
        DispatchQueue(label: "OCR").async {
            self.OCR.recognize(cropped) { (recognizedString) in
                //Parsing of string for price values
                if(recognizedString.validate() && recognizedString.length <= 5){
                    
                    for characters in recognizedString.characters{
                        if (characters == "$" && characters != "I"){
                            
                            guard let dollars = recognizedString.components(separatedBy: recognizedString[recognizedString.length - 2]).first?.components(separatedBy: "$").last else { return }
                            
                            guard let cents = recognizedString.components(separatedBy: recognizedString[recognizedString.length - 3]).last else { return }
                            if(dollars.validateOnlyNumbers() && cents.validateOnlyNumbers() && cents.length == 2 && dollars.length >= 1){
                                priceString = "\(String(describing: dollars)).\(String(describing: cents))"
                            }
                        } else
                            if (characters != "$" && characters == "I"){
                                guard let dollars = recognizedString.components(separatedBy: "I").first else { return }
                                guard let cents = recognizedString.components(separatedBy: recognizedString[recognizedString.length - 3]).last else { return }
                                if(dollars.validateOnlyNumbers() && cents.validateOnlyNumbers() && cents.length == 2 && dollars.length >= 1){
                                    priceString = "\(String(describing: dollars)).\(String(describing: cents))"
                                }
                            } else {
                                guard let dollars = recognizedString.components(separatedBy: recognizedString[recognizedString.length - 2]).first else { return }
                                
                                guard let cents = recognizedString.components(separatedBy: recognizedString[recognizedString.length - 3]).last else { return }
                                if(dollars.validateOnlyNumbers() && cents.validateOnlyNumbers() && cents.length == 2 && dollars.length >= 1){
                                    priceString = "\(String(describing: dollars)).\(String(describing: cents))"
                                }
                        }
                        
                    }
                    callback(priceString)
                }
            }
        }
    }
    
    //Handles cropping the image before processing in the OCR to help with getting only the text desired
    func prepareImageForCrop (using image: UIImage) -> UIImage {
        let degreesToRadians: (CGFloat) -> CGFloat = {
            return $0 / 180.0 * CGFloat(Float.pi)
        }
        
        let imageOrientation = image.imageOrientation
        let degree = image.detectOrientationDegree()
        let cropSize = CGSize(width: 400, height: 110)
        
        //Downscale
        let cgImage = image.cgImage!
        
        let width = cropSize.width
        let height = image.size.height / image.size.width * cropSize.width
        
        let bitsPerComponent = cgImage.bitsPerComponent
        let bytesPerRow = cgImage.bytesPerRow
        let colorSpace = cgImage.colorSpace
        let bitmapInfo = cgImage.bitmapInfo
        
        let context = CGContext(data: nil,
                                width: Int(width),
                                height: Int(height),
                                bitsPerComponent: bitsPerComponent,
                                bytesPerRow: bytesPerRow,
                                space: colorSpace!,
                                bitmapInfo: bitmapInfo.rawValue)
        
        context!.interpolationQuality = CGInterpolationQuality.none
        // Rotate the image context
        context?.rotate(by: degreesToRadians(degree));
        // Now, draw the rotated/scaled image into the context
        context?.scaleBy(x: -1.0, y: -1.0)
        
        //Crop
        switch imageOrientation {
        case .right, .rightMirrored:
            context?.draw(cgImage, in: CGRect(x: -height, y: 0, width: height, height: width))
        case .left, .leftMirrored:
            context?.draw(cgImage, in: CGRect(x: 0, y: -width, width: height, height: width))
        case .up, .upMirrored:
            context?.draw(cgImage, in: CGRect(x: 0, y: 0, width: width, height: height))
        case .down, .downMirrored:
            context?.draw(cgImage, in: CGRect(x: -width, y: -height, width: width, height: height))
        }
        
        let calculatedFrame = CGRect(x: 0, y: CGFloat((height - cropSize.height)/2.0), width: cropSize.width, height: cropSize.height)
        let scaledCGImage = context?.makeImage()?.cropping(to: calculatedFrame)
        
        
        return UIImage(cgImage: scaledCGImage!)
    }
    
}

//MARK: UIImage
extension UIImage {
    func detectOrientationDegree () -> CGFloat {
        switch imageOrientation {
        case .right, .rightMirrored:    return 90
        case .left, .leftMirrored:      return -90
        case .up, .upMirrored:          return 180
        case .down, .downMirrored:      return 0
        }
    }
}
