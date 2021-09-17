//
//  File.swift
//  
//
//  Created by Dans Multipro on 10/09/21.
//

import Core
import Combine
import RealmSwift
import Foundation

public struct GetHomeLocalDataSource: LocalDataSource {
  public typealias Request = Any
  public typealias Response = MovieModuleEntity
  
  private let _realm: Realm
  
  public init(realm: Realm) {
    _realm = realm
  }
  
  public func list(request: Any?) -> AnyPublisher<[MovieModuleEntity], Error> {
    return Future<[MovieModuleEntity], Error> { completion in
      let movies: Results<MovieModuleEntity> = {
        _realm.objects(MovieModuleEntity.self)
      }()
      completion(.success(movies.toArray(ofType: MovieModuleEntity.self)))
    }.eraseToAnyPublisher()
  }

  public func add(entities: [MovieModuleEntity]) -> AnyPublisher<Bool, Error> {
    return Future<Bool, Error> { completion in
      do {
        try _realm.write {
          for movie in entities {
            _realm.add(movie, update: .all)
          }
          completion(.success(true))
        }
      } catch {
        completion(.failure(DatabaseError.requestFailed))
      }
    }.eraseToAnyPublisher()
  }

  public func get(id: String) -> AnyPublisher<MovieModuleEntity, Error> {
    fatalError()
  }

  public func update(id: Int, entity: MovieModuleEntity) -> AnyPublisher<Bool, Error> {
    fatalError()
  }
}
