//
//  HomeRouter.swift
//  Muvi
//
//  Created by Dans Multipro on 22/08/21.
//

import SwiftUI

class HomeRouter {

  func makeDetailView(for movie: MovieModel) -> some View {
    let detailUseCase = Injection.init().provideDetail(movie: movie)
    let presenter = MovieDetailPresenter(detailUseCase: detailUseCase)
    return MovieDetailView(presenter: presenter)
  }
}
