//
//  OCRExtensions.swift
//  CartTrackr
//
//  Created by Jay Balderas on 6/14/17.
//  Copyright © 2017 Christina Lee. All rights reserved.
//

import Foundation

//Helper for parsing. Will only validate readings that contain numbers.
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
//Helper for price parsing. Will get certain characters of a string.
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
//Will only return value if there is 3 consecutive readings
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
extension String{
    func fullDollarValue(dollar: String) -> String{
        var newDollar: String! = ""
        
        let fullDollar = dollar.replacingOccurrences(of: ".", with: "", options: NSString.CompareOptions.literal, range:nil)
        
        newDollar = fullDollar.appending(".00")
        return newDollar
    }
    
}
extension String{
    func decimalValue(dollar: String) -> String {
        let tempDollar = dollar
        var decimalValue: String! = ""
        
        let dollars = tempDollar.components(separatedBy: ".").first
        let cents = dollars?.components(separatedBy: dollars![dollars!.length - 3]).last
        
        decimalValue = "\(String(describing: dollars)).\(String(describing: cents))"
        
        return decimalValue
    }
}
