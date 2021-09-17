//
//  DetailUseCase.swift
//  Muvi
//
//  Created by Dans Multipro on 28/08/21.
//

import Foundation
import Combine

protocol DetailUseCase {
  func getMovie() -> MovieModel
  func getMovie() -> AnyPublisher<MovieModel, Error>
  func updateFavoriteMovie() -> AnyPublisher<MovieModel, Error>
}

class DetailInteractor: DetailUseCase {
  private let repository: MovieRepositoryProtocol
  private let movie: MovieModel
  
  required init(repository: MovieRepositoryProtocol, movie: MovieModel) {
    self.repository = repository
    self.movie = movie
  }
  
  func getMovie() -> MovieModel {
    return movie
  }

  func getMovie() -> AnyPublisher<MovieModel, Error> {
    return repository.getMovie(by: movie.id)
  }
  
  func updateFavoriteMovie() -> AnyPublisher<MovieModel, Error> {
      return repository.updateFavoriteMovie(by: movie.id)
    }
}
