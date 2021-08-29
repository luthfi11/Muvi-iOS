//
//  FavoriteRouter.swift
//  Muvi
//
//  Created by Dans Multipro on 29/08/21.
//


import SwiftUI

class FavoriteRouter {

  func makeMealView(for movie: MovieModel) -> some View {
    let detailUseCase = Injection.init().provideDetail(movie: movie)
    let presenter = MovieDetailPresenter(detailUseCase: detailUseCase)
    return MovieDetailView(presenter: presenter)
  }
}
