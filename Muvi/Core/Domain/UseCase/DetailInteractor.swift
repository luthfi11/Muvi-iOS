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
}
