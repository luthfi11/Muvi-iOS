//
//  MovieRepository.swift
//  Muvi
//
//  Created by Dans Multipro on 15/08/21.
//

import Foundation
import Combine

protocol MovieRepositoryProtocol {
  func getMovies() -> AnyPublisher<[MovieModel], Error>
  func getMovie(by id: Int) -> AnyPublisher<MovieModel, Error>
  func updateFavoriteMovie(by id: Int) -> AnyPublisher<MovieModel, Error>
  func getFavoriteMovies() -> AnyPublisher<[MovieModel], Error>
}

final class MovieRepository: NSObject {
  typealias MovieInstance = (LocalDataSource, RemoteDataSource) -> MovieRepository
  
  fileprivate let remote: RemoteDataSource
  fileprivate let local: LocalDataSource
  
  private init(local: LocalDataSource, remote: RemoteDataSource) {
    self.local = local
    self.remote = remote
  }
  
  static let sharedInstance: MovieInstance = { localRepo, remoteRepo in
    return MovieRepository(local: localRepo, remote: remoteRepo)
  }
}

extension MovieRepository: MovieRepositoryProtocol {
  
  func getMovies() -> AnyPublisher<[MovieModel], Error> {
    return self.local.getMovies()
      .flatMap { result -> AnyPublisher<[MovieModel], Error> in
        if result.isEmpty {
          return self.remote.getMovies()
            .map { MovieMapper.mapMovieResponsesToEntities(input: $0) }
            .flatMap { self.local.addMovies(from: $0) }
            .filter { $0 }
            .flatMap { _ in self.local.getMovies()
              .map { MovieMapper.mapMovieEntitiesToDomains(input: $0) }
            }
            .eraseToAnyPublisher()
        } else {
          return self.local.getMovies()
            .map { MovieMapper.mapMovieEntitiesToDomains(input: $0) }
            .eraseToAnyPublisher()
        }
      }.eraseToAnyPublisher()
  }
  
  func getMovie(by id: Int) -> AnyPublisher<MovieModel, Error> {
    return self.local.getMovie(by: id)
      .map { MovieMapper.mapMovieEntityToDomains(input: $0) }
      .eraseToAnyPublisher()
  }
  
  func getFavoriteMovies() -> AnyPublisher<[MovieModel], Error> {
    return self.local.getFavoriteMovies()
      .map { MovieMapper.mapMovieEntitiesToDomains(input: $0) }
      .eraseToAnyPublisher()
  }
  
  func updateFavoriteMovie(by id: Int) -> AnyPublisher<MovieModel, Error> {
    return self.local.updateFavoriteMovie(by: id)
      .map { MovieMapper.mapMovieEntityToDomains(input: $0) }
      .eraseToAnyPublisher()
  }
}
