//
//  SearchInteractor.swift
//  Muvi
//
//  Created by Dans Multipro on 29/08/21.
//

import Foundation
import Combine

protocol SearchUseCase {
  func searchMovies(by title: String) -> AnyPublisher<[MovieModel], Error>
}

class SearchInteractor: SearchUseCase {
  private let repository: MovieRepositoryProtocol
  
  required init(repository: MovieRepositoryProtocol) {
    self.repository = repository
  }
  
  func searchMovies(by title: String) -> AnyPublisher<[MovieModel], Error> {
    return repository.searchMovies(by: title)
  }
}
