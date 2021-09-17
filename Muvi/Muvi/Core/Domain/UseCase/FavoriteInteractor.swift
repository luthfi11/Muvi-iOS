//
//  FavoriteInteractor.swift
//  Muvi
//
//  Created by Dans Multipro on 29/08/21.
//

import Foundation
import Combine

protocol FavoriteUseCase {
  func getFavoriteMovies() -> AnyPublisher<[MovieModel], Error>
}

class FavoriteInteractor: FavoriteUseCase {
  private let repository: MovieRepositoryProtocol

  required init(repository: MovieRepositoryProtocol) {
    self.repository = repository
  }

  func getFavoriteMovies() -> AnyPublisher<[MovieModel], Error> {
    return repository.getFavoriteMovies()
  }
}
