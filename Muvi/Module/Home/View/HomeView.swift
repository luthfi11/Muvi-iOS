//
//  HomeView.swift
//  Muvi
//
//  Created by Dans Multipro on 22/08/21.
//

import SwiftUI

struct HomeView: View {
  @ObservedObject var presenter: HomePresenter
  let gridItem = [GridItem(.flexible()), GridItem(.flexible())]
  
  var body: some View {
    ZStack {
      if presenter.loadingState {
        ProgressView()
          .frame(width: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, height: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
      } else {
        ScrollView {
          LazyVGrid(columns: gridItem) {
            ForEach(self.presenter.movies, id: \.id) { movie in
              MovieGrid(movie: movie)
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
