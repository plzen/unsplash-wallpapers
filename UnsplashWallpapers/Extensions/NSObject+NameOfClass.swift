//
//  NSObject+NameOfClass.swift
//  UnsplashWallpapers
//
//  Created by Mykola Voronin on 10/10/17.
//  Copyright © 2017 Mykola Voronin. All rights reserved.
//

import Foundation

extension NSObject {
    
    static var nameOfClass: String {
        return NSStringFromClass(self).components(separatedBy: ".").last!
    }
    
    var nameOfClass: String {
        return NSStringFromClass(type(of: self)).components(separatedBy: ".").last!
    }
}
