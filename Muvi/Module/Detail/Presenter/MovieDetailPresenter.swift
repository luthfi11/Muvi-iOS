//
//  MovieDetailPresenter.swift
//  Muvi
//
//  Created by Dans Multipro on 28/08/21.
//

import SwiftUI
import Combine

class MovieDetailPresenter: ObservableObject {
  
  private let detailUseCase: DetailUseCase

  @Published var movie: MovieModel

  init(detailUseCase: DetailUseCase) {
    self.detailUseCase = detailUseCase
    movie = detailUseCase.getMovie()
  }
}
