//
//  File.swift
//  
//
//  Created by Reza Kurniawan on 08/04/25.
//

import Foundation

public struct Endpoint {
    public let path: String
    public let method: HTTPMethod
    public let headers: [String: String]?
    public let queryItems: [URLQueryItem]?
    public let body: [String: Any]?
    public let encoding: RequestEncoding
    public let multipartData: [MultipartFormDataItem]?

    public init(
        path: String,
        method: HTTPMethod = .get,
        headers: [String: String]? = nil,
        queryItems: [URLQueryItem]? = nil,
        body: [String: Any]? = nil,
        encoding: RequestEncoding = .json,
        multipartData: [MultipartFormDataItem]? = nil
    ) {
        self.path = path
        self.method = method
        self.headers = headers
        self.queryItems = queryItems
        self.body = body
        self.encoding = encoding
        self.multipartData = multipartData
    }
}


public enum HTTPMethod: String {
    case get, post, put, delete, patch
}

public struct MultipartFormDataItem {
    public let name: String
    public let fileName: String
    public let mimeType: String
    public let data: Data

    public init(name: String, fileName: String, mimeType: String, data: Data) {
        self.name = name
        self.fileName = fileName
        self.mimeType = mimeType
        self.data = data
    }
}

public enum RequestEncoding {
    case json
    case formURLEncoded
    case multipart
}
