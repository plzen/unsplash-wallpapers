//
//  DesktopPictureService.swift
//  UnsplashWallpapers
//
//  Created by Mykola Voronin on 10/11/17.
//  Copyright © 2017 Mykola Voronin. All rights reserved.
//

import AppKit

class DesktopPictureService {
    
    func setDesktopPicture(url: URL) {
        let workspace = NSWorkspace.shared()
        if let screens = NSScreen.screens(), screens.count > 0 {
            let screen = screens[0]
            try? workspace.setDesktopImageURL(url, for: screen, options: [:])
        }
    }
    
    func getDesktopPicture() -> URL? {
        let workspace = NSWorkspace.shared()
        if let screens = NSScreen.screens(), screens.count > 0 {
            let screen = screens[0]
            return workspace.desktopImageURL(for: screen)
        }
        return nil
    }
}
