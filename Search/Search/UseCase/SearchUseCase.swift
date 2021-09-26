//
//  SearchUseCase.swift
//  Search
//
//  Created by Dans Multipro on 26/09/21.
//

import Foundation
import Combine
import Core

public protocol SearchUseCase {
  func searchMovies(by title: String) -> AnyPublisher<[MovieModel], Error>
}

public class SearchInteractor: SearchUseCase {
  private let repository: MovieRepositoryProtocol
  
  public required init(repository: MovieRepositoryProtocol) {
    self.repository = repository
  }
  
  public func searchMovies(by title: String) -> AnyPublisher<[MovieModel], Error> {
    return repository.searchMovies(by: title)
  }
}
