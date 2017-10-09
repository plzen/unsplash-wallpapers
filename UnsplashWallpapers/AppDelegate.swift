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
    
    // MARK: - Constants
    
    private let refreshTimeout: TimeInterval = 1 * 60 // every 5 minutes
    
    // MARK: - Private
    
    private var client: APIClient!
    
    private let popover = NSPopover()
    private var statusItem: NSStatusItem?
    private var updateTimer: Timer?
    
    // MARK: - Public
    
    var imageFetcher: ImageFetcher!
    var defaultsService: UserDefaultsService!
    var desktopPictureService: DesktopPictureService!
    
    override init() {
        super.init()
        
        client = APIClient()
        defaultsService = UserDefaultsService()
        desktopPictureService = DesktopPictureService()
        imageFetcher = ImageFetcher(client: client, defaultsService: defaultsService, desktopPictureService: desktopPictureService)
    }
    
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        statusItem = NSStatusBar.system().statusItem(withLength: NSSquareStatusItemLength)
        
        if let button = statusItem?.button {
            button.image = NSImage(named: "StatusIcon")
            button.action = #selector(togglePopover)
        }
        
        let storyboard = NSStoryboard(storyboard: .main)
        let contentViewController: PopoverViewController = storyboard.instantiateViewController()
        popover.contentViewController = contentViewController
        
        updateTimer = Timer.scheduledTimer(timeInterval: refreshTimeout, target: self, selector: #selector(updateImage), userInfo: nil, repeats: true)
        updateImage()
    }
    
    func applicationDidResignActive(_ notification: Notification) {
        hidePopover()
    }
    
    // MARK: - Popover
    
    @objc private func togglePopover() {
        if !popover.isShown {
            showPopover()
        } else {
            hidePopover()
        }
    }
    
    private func showPopover() {
        if !popover.isShown {
            if let button = statusItem?.button {
                NSApplication.shared().activate(ignoringOtherApps: true)
                popover.show(relativeTo: button.bounds, of: button, preferredEdge: .minY)
            }
        }
    }
    
    private func hidePopover() {
        if popover.isShown {
            popover.performClose(self)
        }
    }
    
    // MARK: - Update image
    
    @objc private func updateImage() {
        imageFetcher.fetchPhotoIfNeeded()
    }
}

