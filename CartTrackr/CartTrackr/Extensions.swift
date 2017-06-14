//
//  UIExtensions.swift
//  CartTrackr
//
//  Created by Christina Lee on 4/10/17.
//  Copyright © 2017 Christina Lee. All rights reserved.
//

import UIKit
import Foundation

extension UIResponder {
    static var identifier : String {
        return String(describing: self)
    }
}

//Extension to allow using hex value color selection in code
extension UIColor {
    convenience init(red: Int, green: Int, blue: Int) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")
        
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }
    
    //Converts hex value to Int and applies it to RGB values in correct order
    convenience init(rgb: Int) {
        self.init(
            red: (rgb >> 16) & 0xFF,
            green: (rgb >> 8) & 0xFF,
            blue: rgb & 0xFF
        )
    }
    
    
}

extension String{
    func validate() -> Bool {
        //allowing 0-1 lower-case and upper-case letters, and _- characters
        let pattern = "[^0-9I$]"
        do{
            let regex = try NSRegularExpression(pattern: pattern, options: .caseInsensitive)
            //defines where to start and where to stop
            let range = NSRange(location: 0, length: self.characters.count)
            let matches = regex.numberOfMatches(in: self, options: .reportCompletion, range: range)
            
            if matches > 0 {
                return false
            }
            
            return true //return here if there aren't any matches and if it is less than 0 characters
            
        } catch {
            return false
        }
    }
}

extension String{
    func validateOnlyNumbers() -> Bool {
        //allowing 0-1 lower-case and upper-case letters, and _- characters
        let pattern = "[^0-9]"
        do{
            let regex = try NSRegularExpression(pattern: pattern, options: .caseInsensitive)
            //defines where to start and where to stop
            let range = NSRange(location: 0, length: self.characters.count)
            let matches = regex.numberOfMatches(in: self, options: .reportCompletion, range: range)
            
            if matches > 0 {
                return false
            }
            
            return true //return here if there aren't any matches and if it is less than 0 characters
            
        } catch {
            return false
        }
    }
}

extension String {
    
    var length: Int {
        return self.characters.count
    }
    
    subscript (i: Int) -> String {
        return self[Range(i ..< i + 1)]
    }
    
    func substring(from: Int) -> String {
        return self[Range(min(from, length) ..< length)]
    }
    
    func substring(to: Int) -> String {
        return self[Range(0 ..< max(0, to))]
    }
    
    subscript (r: Range<Int>) -> String {
        let range = Range(uncheckedBounds: (lower: max(0, min(length, r.lowerBound)),
                                            upper: min(length, max(0, r.upperBound))))
        let start = index(startIndex, offsetBy: range.lowerBound)
        let end = index(start, offsetBy: range.upperBound - range.lowerBound)
        return self[Range(start ..< end)]
    }
    
}
//will only return value if there is 3 consecutive readings
extension String{
    func readingValidate(reading: String) -> String {
        var validateArray = OCRPriceString.shared.validateArray
        
        var validReading: String! = "notValid"

        if(validateArray.count < 3){
            validateArray.insert(reading, at: 0)
        }
        if(validateArray.count > 3 || validateArray.count == 3 && validateArray.filter{$0 == reading}.count != 3){
        validateArray.removeLast()
        }
        if(validateArray.count == 3 && validateArray.filter{$0 == reading}.count == 3){
            validReading =  reading
        }
        OCRPriceString.shared.validateArray = validateArray
        return validReading
    }
}
