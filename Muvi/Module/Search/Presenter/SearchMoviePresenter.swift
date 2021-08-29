//
//  SearchMoviePresenter.swift
//  Muvi
//
//  Created by Dans Multipro on 29/08/21.
//

import SwiftUI
import Combine

class SearchMoviePresenter: ObservableObject {
  private var cancellables: Set<AnyCancellable> = []
  private let router = SearchMovieRouter()
  private let searchUseCase: SearchUseCase
  
  @Published var movies: [MovieModel] = []
  @Published var errorMessage: String = ""
  @Published var isLoading: Bool = false
  @Published var isError: Bool = false
  
  var title = ""
  
  init(searchUseCase: SearchUseCase) {
    self.searchUseCase = searchUseCase
  }
  
  func searchMovies() {
    isLoading = true
    searchUseCase.searchMovies(by: title)
      .receive(on: RunLoop.main)
      .sink(receiveCompletion: { completion in
        switch completion {
        case .failure(let error):
          self.errorMessage = error.localizedDescription
          self.isError = true
          self.isLoading = false
        case .finished:
          self.isLoading = false
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
