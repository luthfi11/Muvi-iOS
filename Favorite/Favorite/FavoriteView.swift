//
//  FavoriteView.swift
//  Favorite
//
//  Created by Dans Multipro on 26/09/21.
//

import SwiftUI
import Common

public struct FavoriteView: View {
  
  @ObservedObject var presenter: FavoritePresenter
  
  let gridItem = [GridItem(.flexible()), GridItem(.flexible())]
  
  public init(presenter: FavoritePresenter) {
    self.presenter = presenter
  }

  public var body: some View {
    ZStack {
      if presenter.isLoading {
        ProgressView()
          .frame(width: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, height: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
      } else {
        if presenter.movies.count == 0 {
          Text("No favorite movies yet")
        } else {
          ScrollView {
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
      }
    }
    .onAppear {
      self.presenter.getFavoriteMovies()
    }
    .navigationBarTitle(
      Text("Your Favorite")
    )
  }
}
