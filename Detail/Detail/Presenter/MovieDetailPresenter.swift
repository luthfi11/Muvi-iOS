//
//  MovieDetailPresenter.swift
//  Detail
//
//  Created by Dans Multipro on 26/09/21.
//

import SwiftUI
import Combine
import Core

public class MovieDetailPresenter: ObservableObject {
  
  private var cancellables: Set<AnyCancellable> = []
  private let detailUseCase: DetailUseCase
  
  @Published var movie: MovieModel
  @Published var errorMessage: String = ""
  @Published var isLoading: Bool = false
  @Published var isError: Bool = false
  
  public init(detailUseCase: DetailUseCase) {
    self.detailUseCase = detailUseCase
    movie = detailUseCase.getMovie()
  }
  
  func getMovie() {
    isLoading = true
    detailUseCase.getMovie()
      .receive(on: RunLoop.main)
      .sink(receiveCompletion: { completion in
        switch completion {
        case .failure (let error):
          self.errorMessage = error.localizedDescription
          self.isError = true
          self.isLoading = false
        case .finished:
          self.isLoading = false
        }
      }, receiveValue: { movie in
        self.movie = movie
      })
      .store(in: &cancellables)
  }
  
  func updateFavoriteMeal() {
    detailUseCase.updateFavoriteMovie()
      .receive(on: RunLoop.main)
      .sink(receiveCompletion: { completion in
        switch completion {
        case .failure:
          self.errorMessage = String(describing: completion)
        case .finished:
          self.isLoading = false
        }
      }, receiveValue: { movie in
        self.movie = movie
      })
      .store(in: &cancellables)
  }
}
