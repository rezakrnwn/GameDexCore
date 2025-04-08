//
//  File.swift
//  
//
//  Created by Reza Kurniawan on 08/04/25.
//

import Foundation

public enum APIConfig {
    
    public static var baseURL: String {
        return "https://api.rawg.io"
    }

    public static var apiKey: String {
        return "0f6bdd8fac044347887e3676bb69e227"
    }

    public static let requestTimeout: TimeInterval = 30.0

    public static var defaultHeaders: [String: String] {
        return [
            "Accept": "application/json",
            "Content-Type": "application/json"
        ]
    }

    public static var defaultQueryItems: [URLQueryItem] {
        return [
            URLQueryItem(name: "key", value: apiKey)
        ]
    }
}
