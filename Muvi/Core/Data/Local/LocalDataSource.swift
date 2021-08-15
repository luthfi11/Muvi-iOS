//
//  LocalDataSource.swift
//  Muvi
//
//  Created by Dans Multipro on 15/08/21.
//

import Foundation
import RealmSwift
import Combine

protocol LocalDataSourceProtocol: AnyObject {
  func getMovies() -> AnyPublisher<[MovieEntity], Error>
  func saveMovie(from movie: MovieEntity) -> AnyPublisher<Bool, Error>
}

final class LocalDataSource: NSObject {
  private let realm: Realm?

  private init(realm: Realm?) {
    self.realm = realm
  }

  static let sharedInstance: (Realm?) -> LocalDataSource = { realmDatabase in
    return LocalDataSource(realm: realmDatabase)
  }
}

extension LocalDataSource: LocalDataSourceProtocol {
  func getMovies() -> AnyPublisher<[MovieEntity], Error> {
    return Future<[MovieEntity], Error> { completion in
      if let realm = self.realm {
        let movies: Results<MovieEntity> = {
          realm.objects(MovieEntity.self)
        }()
        completion(.success(movies.toArray(ofType: MovieEntity.self)))
      } else {
        completion(.failure(DatabaseError.invalidInstance))
      }
    }.eraseToAnyPublisher()
  }
  
  func saveMovie(from movie: MovieEntity) -> AnyPublisher<Bool, Error> {
    return Future<Bool, Error> { completion in
      if let realm = self.realm {
        do {
          try realm.write {
            realm.add(movie, update: .all)
            completion(.success(true))
          }
        } catch {
          completion(.failure(DatabaseError.requestFailed))
        }
      } else {
        completion(.failure(DatabaseError.invalidInstance))
      }
    }.eraseToAnyPublisher()
  }
}

extension Results {
  func toArray<T>(ofType: T.Type) -> [T] {
    var array = [T]()
    for index in 0 ..< count {
      if let result = self[index] as? T {
        array.append(result)
      }
    }
    return array
  }
}
