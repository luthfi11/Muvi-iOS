//
//  SearchMovieView.swift
//  Search
//
//  Created by Dans Multipro on 26/09/21.
//

import SwiftUI
import Common

public struct SearchMovieView: View {
  
  @ObservedObject var presenter: SearchMoviePresenter
  @State private var query = ""

  let gridItem = [GridItem(.flexible()), GridItem(.flexible())]
  
  public init(presenter: SearchMoviePresenter) {
    self.presenter = presenter
  }

  public var body: some View {
    VStack {
      searchBar
      ZStack {
        if presenter.isLoading {
          ProgressView()
            .frame(width: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, height: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
        } else {
          ScrollView {
            if presenter.title.isEmpty {
              EmptyView()
            } else if presenter.movies.count == 0 {
              notFoundText
            } else {
              list
            }
          }
        }
      }
      Spacer()
    }
    .navigationBarTitle(
      Text("Search Movie")
    )
  }
}

extension SearchMovieView {
  var searchBar: some View {
    TextField("Search here...", text: $presenter.title)
      .padding(15)
      .background(Color(.systemGray6))
      .cornerRadius(8)
      .padding(.horizontal, 15)
      .padding(.top, 5)
  }
  
  var notFoundText: some View {
    Text("\"\(presenter.title)\" not found")
      .padding(.top, 30)
      .padding(.horizontal, 16)
  }
  
  var list: some View {
    LazyVGrid(columns: gridItem) {
      ForEach(self.presenter.movies, id: \.id) { movie in
        self.presenter.linkBuilder(for: movie) {
          MovieGrid(movie: movie)
        }.buttonStyle(PlainButtonStyle())
      }
    }
    .padding(10)
  }
}
