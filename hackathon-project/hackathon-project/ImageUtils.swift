//
//  ImageUtils.swift
//  hackathon-project
//
//  Created by Kohei Totani on 2016/05/07.
//  Copyright © 2016年 Kohei Totani. All rights reserved.
//

import Foundation
import UIKit

struct ImageUtils {
    static func createImageForFileManager(image: UIImage) -> NSURL {
        let fileManager = NSFileManager.defaultManager()
        let filePath = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0] as String + "/pickedimage.JPG"
        let imageData = UIImageJPEGRepresentation(image, 1.0)
        fileManager.createFileAtPath(filePath, contents: imageData, attributes: nil)
        
        if (fileManager.fileExistsAtPath(filePath)) {
            return NSURL.init(fileURLWithPath: filePath)
        }
        
        return NSURL()
    }
    
    static func getByUrl(url: String) -> UIImage {
        if let url  = NSURL(string: url),
            data = NSData(contentsOfURL: url) {
            
            return UIImage(data: data)!
        }
        
        return UIImage()
    }
    
    static func resize(image: UIImage, width: CGFloat, height: CGFloat) -> UIImage {
        let originalImg = image
        let resizedSize = CGSizeMake(width, height);
        UIGraphicsBeginImageContext(resizedSize);
        originalImg.drawInRect(CGRectMake(0, 0, resizedSize.width, resizedSize.height))

        let resizedImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        
        return resizedImage
    }
}
