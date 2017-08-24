//
//  Utilities.swift
//  Clove
//
//  Created by Sivaprakash Ragavan on 8/22/17.
//  Copyright © 2017 Clove HQ. All rights reserved.
//

import UIKit

class Utilities {
    static func randomString(length: Int) -> String {
        let letters : NSString = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        let len = UInt32(letters.length)
        
        var randomString = ""
        
        for _ in 0 ..< length {
            let rand = arc4random_uniform(len)
            var nextChar = letters.character(at: Int(rand))
            randomString += NSString(characters: &nextChar, length: 1) as String
        }
        
        return randomString
    }
    
    static func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentsDirectory = paths[0]
        return documentsDirectory
    }
    
    static func durationText(duration: Int) -> String {
        let hours = duration / 3600
        let minutes = (duration % 3600) / 60
        let seconds = (duration % 60)
        
        if(hours > 0) {
            return "\(String(format: "%02d", hours)):\(String(format: "%02d", minutes)):\(String(format: "%02d", seconds))"
        } else {
            return "\(String(format: "%02d", minutes)):\(String(format: "%02d", seconds))"
        }
    }
}

