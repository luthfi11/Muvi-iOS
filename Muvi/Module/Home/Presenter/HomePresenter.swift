//
//  HomePresenter.swift
//  Muvi
//
//  Created by Dans Multipro on 22/08/21.
//

import SwiftUI
import Combine

class HomePresenter: ObservableObject {
  private var cancellables: Set<AnyCancellable> = []
  private let router = HomeRouter()
  private let homeUseCase: HomeUseCase
  
  @Published var movies: [MovieModel] = []
  @Published var errorMessage: String = ""
  @Published var loadingState: Bool = false
  
  init(homeUseCase: HomeUseCase) {
    self.homeUseCase = homeUseCase
  }
  
  func getMovies() {
    loadingState = true
    homeUseCase.getMovies()
      .receive(on: RunLoop.main)
      .sink(receiveCompletion: { completion in
        switch completion {
        case .failure:
          self.errorMessage = String(describing: completion)
        case .finished:
          self.loadingState = false
        }
      }, receiveValue: { movies in
        self.movies = movies
      })
      .store(in: &cancellables)
  }
}
