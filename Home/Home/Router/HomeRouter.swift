//
//  HomeRouter.swift
//  Home
//
//  Created by Dans Multipro on 20/09/21.
//

import SwiftUI
import Core
import Detail

public class HomeRouter {
  func makeDetailView(for movie: MovieModel) -> some View {
    let detailUseCase = Injection.init().provideDetail(movie: movie)
    let presenter = MovieDetailPresenter(detailUseCase: detailUseCase)
    return MovieDetailView(presenter: presenter)
  }
}
