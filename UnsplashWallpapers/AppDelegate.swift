//
//  AppDelegate.swift
//  UnsplashWallpapers
//
//  Created by Mykola Voronin on 10/10/17.
//  Copyright © 2017 Mykola Voronin. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {
    
    private let popover = NSPopover()
    private var statusItem: NSStatusItem?
    
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        statusItem = NSStatusBar.system().statusItem(withLength: NSSquareStatusItemLength)
        
        if let button = statusItem?.button {
            button.image = NSImage(named: "StatusIcon")
            button.action = #selector(togglePopover)
        }
        
        let storyboard = NSStoryboard(storyboard: .main)
        let contentViewController: PopoverViewController = storyboard.instantiateViewController()
        popover.contentViewController = contentViewController
    }
    
    func applicationDidResignActive(_ notification: Notification) {
        hidePopover()
    }
    
    // MARK: - Private
    
    @objc private func togglePopover() {
        if !popover.isShown {
            showPopover()
        } else {
            hidePopover()
        }
    }
    
    func showPopover() {
        if !popover.isShown {
            if let button = statusItem?.button {
                NSApplication.shared().activate(ignoringOtherApps: true)
                popover.show(relativeTo: button.bounds, of: button, preferredEdge: .minY)
            }
        }
    }
    
    func hidePopover() {
        if popover.isShown {
            popover.performClose(self)
        }
    }
}

