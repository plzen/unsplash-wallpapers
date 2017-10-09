//
//  NSStoryboard+Identifier.swift
//  UnsplashWallpapers
//
//  Created by Mykola Voronin on 10/10/17.
//  Copyright © 2017 Mykola Voronin. All rights reserved.
//

import Cocoa

extension NSStoryboard {
    
    enum Storyboard: String {
        
        case main
        
        var filename: String {
            return rawValue.capitalized
        }
    }
    
    convenience init(storyboard: Storyboard, bundle: Bundle? = nil) {
        self.init(name: storyboard.filename, bundle: bundle)
    }
    
    func instantiateWindowController<T: NSWindowController>() -> T {
        guard let controller = self.instantiateController(withIdentifier: T.nameOfClass) as? T else {
            fatalError("Couldn't instantiate window controller with identifier \(T.nameOfClass)")
        }
        
        return controller
    }
    
    func instantiateViewController<T: NSViewController>() -> T {
        guard let controller = self.instantiateController(withIdentifier: T.nameOfClass) as? T else {
            fatalError("Couldn't instantiate view controller with identifier \(T.nameOfClass)")
        }
        
        return controller
    }
}
