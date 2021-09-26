//
//  MuviApp.swift
//  Muvi
//
//  Created by Dans Multipro on 15/08/21.
//

import SwiftUI
import Home
import Favorite
import Search

@main
struct MuviApp: App {

  var body: some Scene {
    let homeUseCase = Injection.init().provideHome()
    let homePresenter = HomePresenter(homeUseCase: homeUseCase)
    
    let searchUseCase = Injection.init().provideSearch()
    let searchPresenter = SearchMoviePresenter(searchUseCase: searchUseCase)
    
    let favoriteUseCase = Injection.init().provideFavorite()
    let favoritePresenter = FavoritePresenter(favoriteUseCase: favoriteUseCase)

    WindowGroup {
      ContentView()
        .environmentObject(homePresenter)
        .environmentObject(searchPresenter)
        .environmentObject(favoritePresenter)
    }
  }
}
