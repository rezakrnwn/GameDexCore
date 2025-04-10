//
//  File.swift
//  
//
//  Created by Reza Kurniawan on 09/04/25.
//

import Foundation

public enum NetworkError: LocalizedError {
    case invalidResponse
    case unreachable(URL)
    case decodingError(DecodingError)
    case unknown(Error)

    public var errorDescription: String? {
        switch self {
        case .invalidResponse:
            return "The server responded with an unexpected format."
        case .unreachable(let url):
            return "Cannot reach the server at \(url.absoluteString)."
        case .decodingError(let error):
            return "Decoding failed: \(error.localizedDescription)"
        case .unknown(let error):
            return "Unknown error: \(error.localizedDescription)"
        }
    }
}

public enum DatabaseError: LocalizedError {
    case instanceFailure
    case requestFailed(String)

    public var errorDescription: String? {
        switch self {
        case .instanceFailure:
            return "Database instance could not be initialized."
        case .requestFailed(let reason):
            return "Database request failed: \(reason)."
        }
    }
}
