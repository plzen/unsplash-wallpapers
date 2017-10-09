//
//  FetchInterval.swift
//  UnsplashWallpapers
//
//  Created by Mykola Voronin on 10/11/17.
//  Copyright © 2017 Mykola Voronin. All rights reserved.
//

import Foundation

enum FetchInterval : Int {
    
    // MARK: - Private
    
    private static let minuteInterval: TimeInterval = 60 // 1 min = 60 sec
    
    // MARK: - Case
    
    case min30 = 0
    case hour1
    case hour2
    case hour3
    case hour6
    
    // MARK: - Value
    
    func value() -> TimeInterval {
        let value: TimeInterval
        
        switch self {
        case .min30:
            value = 30
        case .hour1:
            value = 60
        case .hour2:
            value = 120
        case .hour3:
            value = 180
        case .hour6:
            value = 360
        }
        
        return value * FetchInterval.minuteInterval
    }
}
