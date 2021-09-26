//
//  GetHomeUseCase.swift
//  Home
//
//  Created by Dans Multipro on 19/09/21.
//

import Foundation
import Combine
import Core

public protocol HomeUseCase {
  func getMovies() -> AnyPublisher<[MovieModel], Error>
}

public class HomeInteractor: HomeUseCase {
  private let repository: MovieRepositoryProtocol
  
  public required init(repository: MovieRepositoryProtocol) {
    self.repository = repository
  }
  
  public func getMovies() -> AnyPublisher<[MovieModel], Error> {
    return repository.getMovies()
  }
}
