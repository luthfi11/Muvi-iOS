//
//  MovieRepository.swift
//  Core
//
//  Created by Dans Multipro on 24/09/21.
//

import Foundation
import Combine

public protocol MovieRepositoryProtocol {
  func getMovies() -> AnyPublisher<[MovieModel], Error>
  func getMovie(by id: Int) -> AnyPublisher<MovieModel, Error>
  func updateFavoriteMovie(by id: Int) -> AnyPublisher<MovieModel, Error>
  func getFavoriteMovies() -> AnyPublisher<[MovieModel], Error>
  func searchMovies(by title: String) -> AnyPublisher<[MovieModel], Error>
}

public final class MovieRepository: NSObject {
  public typealias MovieInstance = (LocalDataSource, RemoteDataSource) -> MovieRepository
  
  fileprivate let remote: RemoteDataSource
  fileprivate let local: LocalDataSource
  
  private init(local: LocalDataSource, remote: RemoteDataSource) {
    self.local = local
    self.remote = remote
  }
  
  public static let sharedInstance: MovieInstance = { localRepo, remoteRepo in
    return MovieRepository(local: localRepo, remote: remoteRepo)
  }
}

extension MovieRepository: MovieRepositoryProtocol {
  
  public func getMovies() -> AnyPublisher<[MovieModel], Error> {
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
  
  public func getMovie(by id: Int) -> AnyPublisher<MovieModel, Error> {
    return self.local.getMovie(by: id)
      .map { MovieMapper.mapMovieEntityToDomains(input: $0) }
      .eraseToAnyPublisher()
  }
  
  public func getFavoriteMovies() -> AnyPublisher<[MovieModel], Error> {
    return self.local.getFavoriteMovies()
      .map { MovieMapper.mapMovieEntitiesToDomains(input: $0) }
      .eraseToAnyPublisher()
  }
  
  public func updateFavoriteMovie(by id: Int) -> AnyPublisher<MovieModel, Error> {
    return self.local.updateFavoriteMovie(by: id)
      .map { MovieMapper.mapMovieEntityToDomains(input: $0) }
      .eraseToAnyPublisher()
  }
  
  public func searchMovies(by title: String) -> AnyPublisher<[MovieModel], Error> {
    return self.remote.searchMovies(by: title)
      .map { MovieMapper.mapMovieResponsesToEntities(input: $0) }
      .catch { _ in self.local.getMoviesByTitle(title) }
      .flatMap { responses  in
        self.local.getMoviesByTitle(title)
          .flatMap { local -> AnyPublisher<[MovieModel], Error> in
            if responses.count > local.count {
              return self.local.addMoviesByTitle(title, from: responses)
                .filter { $0 }
                .flatMap { _ in self.local.getMoviesByTitle(title)
                  .map { MovieMapper.mapMovieEntitiesToDomains(input: $0) }
                }.eraseToAnyPublisher()
            } else {
              return self.local.getMoviesByTitle(title)
                .map { MovieMapper.mapMovieEntitiesToDomains(input: $0) }
                .eraseToAnyPublisher()
            }
          }
      }.eraseToAnyPublisher()
  }
}
