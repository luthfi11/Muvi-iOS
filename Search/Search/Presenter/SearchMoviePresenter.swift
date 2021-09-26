//
//  SearchMoviePresenter.swift
//  Search
//
//  Created by Dans Multipro on 26/09/21.
//

import SwiftUI
import Combine
import Core

public class SearchMoviePresenter: ObservableObject {
  private var cancellables: Set<AnyCancellable> = []
  private let router = SearchMovieRouter()
  private let searchUseCase: SearchUseCase
  
  @Published var movies: [MovieModel] = []
  @Published var errorMessage: String = ""
  @Published var isLoading: Bool = false
  @Published var isError: Bool = false
  @Published var title: String = ""
  
  public init(searchUseCase: SearchUseCase) {
    self.searchUseCase = searchUseCase
    binding()
  }
  
  func binding() {
    $title
      .debounce(for: 0.5, scheduler: DispatchQueue.main)
      .sink { [weak self] _ in
        self?.searchMovies()
      }
      .store(in: &cancellables)
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
