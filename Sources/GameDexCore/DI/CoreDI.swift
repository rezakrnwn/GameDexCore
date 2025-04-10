//
//  File.swift
//  
//
//  Created by Reza Kurniawan on 08/04/25.
//

import Foundation
import Resolver

public extension Resolver {
    static func registerCoreDependencies() {
        register { AlamofireNetworkClient(
            baseURL: APIConfig.baseURL,
            defaultQueryItems: APIConfig.defaultQueryItems) as NetworkClient
        }.scope(.application)
        register {
            do {
                return try RealmDatabase() as LocalDatabase
            } catch {
                fatalError("RealmDatabase init failed: \(error.localizedDescription)")
                return nil
            }
        }.scope(.application)
    }
}
