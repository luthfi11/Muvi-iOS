//
//  LocalDataSource.swift
//  Core
//
//  Created by Dans Multipro on 24/09/21.
//

import Foundation
import RealmSwift
import Combine

public protocol LocalDataSourceProtocol: AnyObject {
  func getMovies() -> AnyPublisher<[MovieEntity], Error>
  func getMovie(by id: Int) -> AnyPublisher<MovieEntity, Error>
  func addMovies(from movies: [MovieEntity]) -> AnyPublisher<Bool, Error>
  func updateFavoriteMovie(by id: Int) -> AnyPublisher<MovieEntity, Error>
  func getFavoriteMovies() -> AnyPublisher<[MovieEntity], Error>
  func getMoviesByTitle(_ title: String) -> AnyPublisher<[MovieEntity], Error>
  func addMoviesByTitle(_ title: String, from movies: [MovieEntity]) -> AnyPublisher<Bool, Error>
}

public final class LocalDataSource: NSObject {
  private let realm: Realm?
  
  private init(realm: Realm?) {
    self.realm = realm
  }
  
  public static let sharedInstance: (Realm?) -> LocalDataSource = { realmDatabase in
    return LocalDataSource(realm: realmDatabase)
  }
}

extension LocalDataSource: LocalDataSourceProtocol {
  
  public func getMovies() -> AnyPublisher<[MovieEntity], Error> {
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
  
  public func getMovie(by id: Int) -> AnyPublisher<MovieEntity, Error> {
    return Future<MovieEntity, Error> { completion in
      if let realm = self.realm {
        let movies: Results<MovieEntity> = {
          realm.objects(MovieEntity.self).filter("id = \(id)")
        }()
        guard let movie = movies.first else {
          completion(.failure(DatabaseError.requestFailed))
          return
        }
        completion(.success(movie))
      } else {
        completion(.failure(DatabaseError.invalidInstance))
      }
    }.eraseToAnyPublisher()
  }
  
  public func addMovies(from movies: [MovieEntity]) -> AnyPublisher<Bool, Error> {
    return Future<Bool, Error> { completion in
      if let realm = self.realm {
        do {
          try realm.write {
            for movie in movies {
              realm.add(movie, update: .all)
            }
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
  
  public func updateFavoriteMovie(by id: Int) -> AnyPublisher<MovieEntity, Error> {
    return Future<MovieEntity, Error> { completion in
      if let realm = self.realm, let movieEntity = {
        realm.objects(MovieEntity.self).filter("id = \(id)")
      }().first {
        do {
          try realm.write {
            movieEntity.setValue(!movieEntity.favorite, forKey: "favorite")
          }
          completion(.success(movieEntity))
        } catch {
          completion(.failure(DatabaseError.requestFailed))
        }
      } else {
        completion(.failure(DatabaseError.invalidInstance))
      }
    }.eraseToAnyPublisher()
  }
  
  public func getFavoriteMovies() -> AnyPublisher<[MovieEntity], Error> {
    return Future<[MovieEntity], Error> { completion in
      if let realm = self.realm {
        let movieEntities = {
          realm.objects(MovieEntity.self)
            .filter("favorite = \(true)")
        }()
        completion(.success(movieEntities.toArray(ofType: MovieEntity.self)))
      } else {
        completion(.failure(DatabaseError.invalidInstance))
      }
    }.eraseToAnyPublisher()
  }
  
  public func getMoviesByTitle(_ title: String) -> AnyPublisher<[MovieEntity], Error> {
    return Future<[MovieEntity], Error> { completion in
      if let realm = self.realm {
        let movies: Results<MovieEntity> = {
          realm.objects(MovieEntity.self)
            .filter("title contains[c] %@", title)
        }()
        completion(.success(movies.toArray(ofType: MovieEntity.self)))
      } else {
        completion(.failure(DatabaseError.invalidInstance))
      }
    }.eraseToAnyPublisher()
  }
  
  public func addMoviesByTitle(_ title: String, from movies: [MovieEntity]) -> AnyPublisher<Bool, Error> {
    return Future<Bool, Error> { completion in
      if let realm = self.realm {
        do {
          try realm.write {
            for movie in movies {
              if let movieEntity = realm.object(ofType: MovieEntity.self, forPrimaryKey: movie.id) {
                if movieEntity.title == movieEntity.title {
                  movie.favorite = movieEntity.favorite
                  realm.add(movie, update: .all)
                } else {
                  realm.add(movie)
                }
              } else {
                realm.add(movie)
              }
            }
          }
          completion(.success(true))
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
