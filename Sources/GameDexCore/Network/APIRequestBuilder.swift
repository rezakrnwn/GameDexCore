//
//  File.swift
//  
//
//  Created by Reza Kurniawan on 08/04/25.
//

import Foundation

public struct APIRequestBuilder {
    public static func url(from endpoint: Endpoint, baseURL: String) -> URL? {
        var components = URLComponents(string: baseURL + endpoint.path)
        components?.queryItems = endpoint.queryItems
        return components?.url
    }
}
