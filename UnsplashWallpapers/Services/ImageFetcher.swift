//
//  ImageFetcher.swift
//  UnsplashWallpapers
//
//  Created by Mykola Voronin on 10/11/17.
//  Copyright © 2017 Mykola Voronin. All rights reserved.
//

import Foundation

//typealias ImageFetchCompletion = () -> Void

class ImageFetcher {
    
    // MARK: - Constants
    
    public static let ImageFetched = Notification.Name(rawValue: "com.mvoronin.UnsplashWallpapers.imageFetched")
    
    // MARK: - Private
    
    private let client: APIClient
    private let defaultsService: UserDefaultsService
    private let desktopPictureService: DesktopPictureService
    
    // MARK: - Constructors
    
    init(client: APIClient, defaultsService: UserDefaultsService, desktopPictureService: DesktopPictureService) {
        self.client = client
        self.defaultsService = defaultsService
        self.desktopPictureService = desktopPictureService
    }
    
    // MARK: - Fetch photo
    
    func fetchPhotoIfNeeded() {
        let fetchInterval = defaultsService.fetchInterval
        let lastUpdated = defaultsService.lastUpdated
        
        if lastUpdated == nil {
            fetchPhoto()
            return
        }
        
        if let intervalSinceLastUpdate = lastUpdated?.timeIntervalSinceNow, abs(intervalSinceLastUpdate) > fetchInterval.value() {
            
            fetchPhoto()
            return
        }
    }
    
    func fetchPhoto() {
        client.getRandomPhoto { photo, error in
            if let photo = photo {
                self.downloadFile(url: photo.url)
            } else {
                NotificationCenter.default.post(name: ImageFetcher.ImageFetched, object: nil)
            }
        }
    }
    
    private func downloadFile(url: String) {
        client.downloadPhoto(url: url) { [unowned self] destinationUrl, error in
            if let destinationUrl = destinationUrl {
                self.setDesktopPicture(url: destinationUrl)
                self.defaultsService.lastUpdated = Date()
            }
            
            NotificationCenter.default.post(name: ImageFetcher.ImageFetched, object: nil)
        }
    }
    
    // MARK: - Set desktop picture
    
    private func setDesktopPicture(url: URL) {
        desktopPictureService.setDesktopPicture(url: url)
    }
}
