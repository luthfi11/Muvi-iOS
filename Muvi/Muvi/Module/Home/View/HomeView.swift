//
//  HomeView.swift
//  Muvi
//
//  Created by Dans Multipro on 22/08/21.
//

import SwiftUI
import Core
import Home

struct HomeView: View {

  @ObservedObject var presenter: GetListPresenter<Any, MovieDomainModel, Interactor<Any, [MovieDomainModel], GetHomeRepository<GetHomeLocalDataSource, GetHomeRemoteDataSource, MovieTransformer>>>

  let gridItem = [GridItem(.flexible()), GridItem(.flexible())]
  
  var body: some View {
    ZStack {
      if presenter.isLoading {
        ProgressView()
          .frame(width: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, height: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
      } else {
        ScrollView {
          LazyVGrid(columns: gridItem) {
            ForEach(self.presenter.list, id: \.id) { movie in
              ZStack {
                MovieGrid(movie: movie)
              }.buttonStyle(PlainButtonStyle())
            }
          }
          .padding(10)
        }
      }
    }
    .onAppear {
      if self.presenter.list.count == 0 {
        self.presenter.getList(request: nil)
      }
    }
    .navigationBarTitle(
      Text("Now Playing")
    )
  }
}
