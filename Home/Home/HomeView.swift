//
//  HomeView.swift
//  Home
//
//  Created by Dans Multipro on 19/09/21.
//

import SwiftUI
import Core
import Common

public struct HomeView: View {

  @ObservedObject var presenter: HomePresenter

  let gridItem = [GridItem(.flexible()), GridItem(.flexible())]
  
  public init(presenter: HomePresenter) {
    self.presenter = presenter
  }
  
  public var body: some View {
    ZStack {
      if presenter.loadingState {
        ProgressView()
          .frame(width: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, height: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
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
    .onAppear {
      if self.presenter.movies.count == 0 {
        self.presenter.getMovies()
      }
    }
    .navigationBarTitle(
      Text("Now Playing")
    )
  }
}
