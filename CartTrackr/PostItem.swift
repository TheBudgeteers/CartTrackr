//
//  PostItem.swift
//  CartTrackr
//
//  Created by Christina Lee on 4/12/17.
//  Copyright © 2017 Christina Lee. All rights reserved.
//

import UIKit
import CloudKit

class PostItem {
    let price : String
    let description : String
    let quantity : Int
    
    init(price: String, description: String, quantity: Int) {
        self.price = price
        self.description = description
        self.quantity = quantity
    }
}

//extension PostItem {
//    class func recordFor(postItem: PostItem) {
//    let record = CKRecord(recordType: "CartItem")
//    record["Price"] = "price"
//    record["Description"] = "description"
//    record["Quantity"] = "quantity"
//    }
//}

//extension Post {
//    class func recordFor(post: Post) throws -> CKRecord? {
//        guard let data = UIImageJPEGRepresentation(post.image, 0.7) else { throw PostError.writingImageToData }
//        
//        do {
//            try data.write(to: post.image.path)
//            
//            let asset = CKAsset(fileURL: post.image.path)
//            let record = CKRecord(recordType: "Post")
//            record.setValue(asset, forKey: "image")
//            
//            return record
//        } catch {
//            throw PostError.writingDataToDisk
//        }
//    }
//}
