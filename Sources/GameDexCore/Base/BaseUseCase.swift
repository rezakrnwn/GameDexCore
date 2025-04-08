//
//  File.swift
//  
//
//  Created by Reza Kurniawan on 07/04/25.
//

import Foundation
import Combine

public protocol BaseUseCase {
    associatedtype Request
    associatedtype Response

    func execute(_ request: Request) -> AnyPublisher<Response, Error>
}
