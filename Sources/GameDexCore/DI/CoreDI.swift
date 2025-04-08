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
            defaultQueryItems: APIConfig.defaultQueryItems)
        }.scope(.application)
        register { RealmDatabase() as LocalDatabase }
    }
}
