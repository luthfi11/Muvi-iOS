//
//  FavoritePresenter.swift
//  Favorite
//
//  Created by Dans Multipro on 26/09/21.
//

import SwiftUI
import Combine
import Core

public class FavoritePresenter: ObservableObject {
  
  private var cancellables: Set<AnyCancellable> = []
  private let router = FavoriteRouter()
  private let favoriteUseCase: FavoriteUseCase
  
  @Published var movies: [MovieModel] = []
  @Published var errorMessage: String = ""
  @Published var isLoading: Bool = false
  @Published var isError: Bool = false
  
  public init(favoriteUseCase: FavoriteUseCase) {
    self.favoriteUseCase = favoriteUseCase
  }
  
  func getFavoriteMovies() {
    isLoading = true
    favoriteUseCase.getFavoriteMovies()
      .receive(on: RunLoop.main)
      .sink(receiveCompletion: { completion in
        switch completion {
        case .failure(let error):
          self.errorMessage = error.localizedDescription
          self.isError = true
        case .finished:
          self.isLoading = false
        }
      }, receiveValue: { movies in
        self.movies = movies
      })
      .store(in: &cancellables)
  }
  
  func linkBuilder<Content: View>(for movie: MovieModel, @ViewBuilder content: () -> Content) -> some View {
    NavigationLink(destination: router.makeMealView(for: movie)) { content() }
  }
}
