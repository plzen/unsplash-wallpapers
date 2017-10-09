//
//  APIClient.swift
//  UnsplashWallpapers
//
//  Created by Mykola Voronin on 10/11/17.
//  Copyright © 2017 Mykola Voronin. All rights reserved.
//

import Alamofire

// MARK: - Constants

private let API_URL = "https://api.unsplash.com"
private let API_KEY = "88da9e653db15ecde79b51bb8be9c76de5005f1119ad50838edd659c2d53eaf0"

// MARK: - Result alias

typealias APIResult<T> = (T?, Error?) -> Void

struct APIClient {
    
    // MARK: - Private static
    
    private static let headers: HTTPHeaders = [
        "Authorization": "Client-ID \(API_KEY)",
        "Accept-Version": "v1"
    ]
    
    // MARK: - Random photo
    
    func getRandomPhoto(_ completion: @escaping APIResult<Photo>) {
        let parameters: [String: Any] = [
            "orientation": "landscape",
            "featured": true
        ]
        
        Alamofire.request("\(API_URL)/photos/random", method: .get, parameters: parameters, encoding: URLEncoding.default, headers: APIClient.headers)
            .validate()
            .responseJSON { response in
                switch response.result {
                case .success(let value):
                    if let json = value as? [String: Any] {
                        let photo = Photo(json: json)
                        completion(photo, nil)
                    } else {
                        // TODO: Add error
                        let error = NSError(domain: "com.nvoronin.UnsplashWallpapers", code: 1001, userInfo: nil)
                        completion(nil, error)
                    }
                case .failure(let error):
                    completion(nil, error)
                }
            }
    }
    
    func downloadPhoto(url: String, completion: @escaping APIResult<URL>) {
        let destination = DownloadRequest.suggestedDownloadDestination()
        
        Alamofire.download(url, to: destination).response { response in
            print(response.request)
            print(response.response)
            print(response.temporaryURL)
            print(response.destinationURL)
            print(response.error)
            
            completion(response.destinationURL, response.error)
        }
    }
}
