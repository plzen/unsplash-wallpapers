//
//  PopoverViewController.swift
//  UnsplashWallpapers
//
//  Created by Mykola Voronin on 10/10/17.
//  Copyright © 2017 Mykola Voronin. All rights reserved.
//

import Cocoa

class PopoverViewController : NSViewController {
    
    // MARK: - Outlets
    
    @IBOutlet private weak var refreshButton: NSButton!
    @IBOutlet private weak var intervalButton: NSPopUpButton!
    @IBOutlet private weak var imageView: NSImageView!
    @IBOutlet private weak var lastUpdatedTextView: NSTextField!
    
    // MARK: - Private
    
    private var imageFetcher: ImageFetcher!
    private var defaultsService: UserDefaultsService!
    private var desktopPictureService: DesktopPictureService!
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupDependencies()
        setupCurrentInterval()
        loadCurrentImage()
        
        NotificationCenter.default.addObserver(self, selector: #selector(didImageFetched), name: ImageFetcher.ImageFetched, object: nil)
    }
    
    override func viewWillAppear() {
        super.viewWillAppear()
        
        showLastUpdatedDate()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: ImageFetcher.ImageFetched, object: nil)
    }
    
    // MARK: - Setup dependencies
    
    private func setupDependencies() {
        let delegate = NSApplication.shared().delegate as! AppDelegate
        
        defaultsService = delegate.defaultsService
        desktopPictureService = delegate.desktopPictureService
        imageFetcher = delegate.imageFetcher
    }
    
    // MARK: - Setup views
    
    private func setupCurrentInterval() {
        intervalButton.selectItem(at: defaultsService.fetchInterval.rawValue)
    }
    
    private func loadCurrentImage() {
        if let url = desktopPictureService.getDesktopPicture() {
            if let data = try? Data(contentsOf: url) {
                let image = NSImage(data: data)
                imageView.image = image
            }
        }
    }
    
    private func showLastUpdatedDate() {
        if let date = defaultsService.lastUpdated {
            lastUpdatedTextView.stringValue = String(format: "Last updated: %@", date.relativelyFormatted)
        } else {
            lastUpdatedTextView.stringValue = ""
        }
    }
    
    // MARK: - Notification handlers
    
    @objc private func didImageFetched() {
        refreshButton.isEnabled = true
        loadCurrentImage()
        showLastUpdatedDate()
    }
    
    // MARK: - Actions
    
    @IBAction func didIntervalChanged(_ sender: Any) {
        defaultsService.fetchInterval = FetchInterval(rawValue: intervalButton.indexOfSelectedItem) ?? .hour1
    }
    
    @IBAction func didRefreshTapped(_ sender: Any) {
        refreshButton.isEnabled = false
        imageFetcher.fetchPhoto()
    }
    
    @IBAction func exitButtonTapped(_ sender: Any) {
        NSApp.terminate(self)
    }
}
