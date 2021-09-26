//
//  GetHomePresenter.swift
//  Home
//
//  Created by Dans Multipro on 19/09/21.
//

import SwiftUI
import Combine
import Core

public class HomePresenter: ObservableObject {
  private var cancellables: Set<AnyCancellable> = []
  private let router = HomeRouter()
  private let homeUseCase: HomeUseCase
  
  @Published var movies: [MovieModel] = []
  @Published var errorMessage: String = ""
  @Published var loadingState: Bool = false
  
  public init(homeUseCase: HomeUseCase) {
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
  
  func linkBuilder<Content: View>(for movie: MovieModel, @ViewBuilder content: () -> Content) -> some View {
    NavigationLink(destination: router.makeDetailView(for: movie)) { content() }
  }
}
