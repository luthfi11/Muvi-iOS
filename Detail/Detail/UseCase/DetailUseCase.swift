//
//  DetailUseCase.swift
//  Detail
//
//  Created by Dans Multipro on 26/09/21.
//

import Foundation
import Combine
import Core

public protocol DetailUseCase {
  func getMovie() -> MovieModel
  func getMovie() -> AnyPublisher<MovieModel, Error>
  func updateFavoriteMovie() -> AnyPublisher<MovieModel, Error>
}

public class DetailInteractor: DetailUseCase {
  private let repository: MovieRepositoryProtocol
  private let movie: MovieModel
  
  public required init(repository: MovieRepositoryProtocol, movie: MovieModel) {
    self.repository = repository
    self.movie = movie
  }
  
  public func getMovie() -> MovieModel {
    return movie
  }
  
  public func getMovie() -> AnyPublisher<MovieModel, Error> {
    return repository.getMovie(by: movie.id)
  }
  
  public func updateFavoriteMovie() -> AnyPublisher<MovieModel, Error> {
    return repository.updateFavoriteMovie(by: movie.id)
  }
}
