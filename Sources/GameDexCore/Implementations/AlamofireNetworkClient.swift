//
//  File.swift
//  
//
//  Created by Reza Kurniawan on 08/04/25.
//

import Foundation
import Combine
import Alamofire

public final class AlamofireNetworkClient: NetworkClient {
    private let baseURL: String
    private let defaultQueryItems: [URLQueryItem]

    public init(baseURL: String, defaultQueryItems: [URLQueryItem]) {
        self.baseURL = baseURL
        self.defaultQueryItems = defaultQueryItems
    }

    public func request<T: Decodable>(
        _ endpoint: Endpoint,
        responseType: T.Type
    ) -> AnyPublisher<T, Error> {
        let fullUrl = baseURL + endpoint.path
        let method = HTTPMethodToAF(endpoint.method)
        
        var urlComponents = URLComponents(string: fullUrl)
        var queryItems = endpoint.queryItems ?? []
        queryItems.append(contentsOf: defaultQueryItems)
        urlComponents?.queryItems = queryItems
        
        guard let url = urlComponents?.url else {
           return Fail(error: URLError(.badURL)).eraseToAnyPublisher()
       }

        let headers = HTTPHeaders(endpoint.headers ?? [:])

        // Multipart upload
        if endpoint.encoding == .multipart, let multipartData = endpoint.multipartData {
            return Future { promise in
                AF.upload(
                    multipartFormData: { form in
                        endpoint.body?.forEach { key, value in
                            if let string = value as? String {
                                form.append(Data(string.utf8), withName: key)
                            }
                        }

                        multipartData.forEach { item in
                            form.append(item.data, withName: item.name, fileName: item.fileName, mimeType: item.mimeType)
                        }
                    },
                    to: url,
                    method: method,
                    headers: headers
                )
                .validate()
                .responseDecodable(of: T.self) { response in
                    switch response.result {
                    case .success(let value):
                        promise(.success(value))
                    case .failure(let error):
                        promise(.failure(error))
                    }
                }
            }
            .eraseToAnyPublisher()
        }

        // JSON / Form URL Encoded
        let encoding: ParameterEncoding = {
            switch endpoint.encoding {
            case .json: return JSONEncoding.default
            case .formURLEncoded: return URLEncoding.default
            default: return JSONEncoding.default
            }
        }()

        return AF.request(
            url,
            method: method,
            parameters: endpoint.body,
            encoding: encoding,
            headers: headers
        )
        .validate()
        .publishDecodable(type: T.self)
        .value()
        .mapError { $0 as Error }
        .eraseToAnyPublisher()
    }

    private func HTTPMethodToAF(_ method: HTTPMethod) -> Alamofire.HTTPMethod {
        switch method {
        case .get: return .get
        case .post: return .post
        case .put: return .put
        case .delete: return .delete
        case .patch: return .patch
        }
    }
}
