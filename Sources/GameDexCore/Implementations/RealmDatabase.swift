//
//  File.swift
//  
//
//  Created by Reza Kurniawan on 08/04/25.
//

import Foundation
import RealmSwift
import Combine

public class RealmDatabase: LocalDatabase {
    private let realm: Realm

    public init(configuration: Realm.Configuration = .defaultConfiguration) {
        self.realm = try! Realm(configuration: configuration)
    }

    public func save<T: Object>(_ object: T) -> AnyPublisher<Bool, Error> {
        Future { promise in
            do {
                try self.realm.write {
                    self.realm.add(object, update: .all)
                }
                promise(.success(true))
            } catch {
                promise(.failure(error))
            }
        }.eraseToAnyPublisher()
    }

    public func fetchAll<T: Object>(of type: T.Type) -> AnyPublisher<[T], Error> {
        let objects = Array(self.realm.objects(type))
        return Just(objects)
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }

    public func delete<T: Object>(_ object: T) -> AnyPublisher<Bool, Error> {
        Future { promise in
            do {
                try self.realm.write {
                    self.realm.delete(object)
                }
                promise(.success(true))
            } catch {
                promise(.failure(error))
            }
        }.eraseToAnyPublisher()
    }
    
    public func find<T: Object, KeyType>(type: T.Type, forPrimaryKey key: KeyType) -> AnyPublisher<T?, Error> {
        let result = self.realm.object(ofType: type, forPrimaryKey: key)
        return Just(result)
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }
    
    public func update(_ block: @escaping (Realm) throws -> Void) -> AnyPublisher<Bool, Error> {
        Future { promise in
            do {
                try self.realm.write {
                    try block(self.realm)
                }
                promise(.success(true))
            } catch {
                promise(.failure(error))
            }
        }
        .eraseToAnyPublisher()
    }
}
