//
//  File.swift
//  
//
//  Created by Reza Kurniawan on 08/04/25.
//

import Foundation

public enum APIEndpoints {
    public static func games() -> Endpoint {
        return Endpoint(path: "/api/games")
    }

    public static func gameDetail(id: Int) -> Endpoint {
        return Endpoint(path: "/api/games/\(id)")
    }
}
