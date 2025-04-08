//
//  File.swift
//  
//
//  Created by Reza Kurniawan on 08/04/25.
//

import Foundation
import Combine
import RealmSwift

public protocol LocalDatabase {
    func save<T: Object>(_ object: T) -> AnyPublisher<Bool, Error>
    func fetchAll<T: Object>(of type: T.Type) -> AnyPublisher<[T], Error>
    func delete<T: Object>(_ object: T) -> AnyPublisher<Bool, Error>
    func find<T: Object, KeyType>(type: T.Type, forPrimaryKey key: KeyType) -> AnyPublisher<T?, Error>
    func update(_ block: @escaping (Realm) throws -> Void) -> AnyPublisher<Bool, Error>
}
