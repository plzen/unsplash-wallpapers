//
//  UserDefaultsService.swift
//  UnsplashWallpapers
//
//  Created by Mykola Voronin on 10/11/17.
//  Copyright © 2017 Mykola Voronin. All rights reserved.
//

import Foundation

class UserDefaultsService {
    
    // MARK: - Constants
    
    private static let keyLastUpdated = "last_updated"
    private static let keyFetchInterval = "fetch_interval"
    
    // MARK: - Private
    
    private let userDefaults = UserDefaults()
    
    // MARK: - Variables
    
    var lastUpdated: Date? {
        get {
            return userDefaults.object(forKey: UserDefaultsService.keyLastUpdated) as? Date
        }
        set {
            userDefaults.set(newValue, forKey: UserDefaultsService.keyLastUpdated)
        }
    }
    
    var fetchInterval: FetchInterval {
        get {
            let interval = userDefaults.integer(forKey: UserDefaultsService.keyFetchInterval)
            return FetchInterval(rawValue: interval) ?? .hour1
        }
        set {
            userDefaults.set(newValue.rawValue, forKey: UserDefaultsService.keyFetchInterval)
        }
    }
}
