//
//  Photo.swift
//  UnsplashWallpapers
//
//  Created by Mykola Voronin on 10/11/17.
//  Copyright © 2017 Mykola Voronin. All rights reserved.
//

import Foundation

struct Photo {
    
    // MARK: - Variables
    
    let url: String
    
    // MARK: - Constructors
    
    init(url: String) {
        self.url = url
    }
    
    init?(json: [String: Any]) {
        guard let urls = json["urls"] as? [String: String], let url = urls["raw"] else {
            return nil
        }
        
        self.url = url
    }
}
