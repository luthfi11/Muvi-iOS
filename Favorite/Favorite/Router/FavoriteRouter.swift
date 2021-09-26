//
//  FavoriteRouter.swift
//  Favorite
//
//  Created by Dans Multipro on 26/09/21.
//

import SwiftUI
import Core
import Detail

class FavoriteRouter {
  func makeMealView(for movie: MovieModel) -> some View {
    let detailUseCase = Injection.init().provideDetail(movie: movie)
    let presenter = MovieDetailPresenter(detailUseCase: detailUseCase)
    return MovieDetailView(presenter: presenter)
  }
}
