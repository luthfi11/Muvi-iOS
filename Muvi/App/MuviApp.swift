//
//  MuviApp.swift
//  Muvi
//
//  Created by Dans Multipro on 15/08/21.
//

import SwiftUI

@main
struct MuviApp: App {

  var body: some Scene {
    let homeUseCase = Injection.init().provideHome()
    let homePresenter = HomePresenter(homeUseCase: homeUseCase)
    
    let favoriteUseCase = Injection.init().provideFavorite()
    let favoritePresenter = FavoritePresenter(favoriteUseCase: favoriteUseCase)

    WindowGroup {
      ContentView()
        .environmentObject(homePresenter)
        .environmentObject(favoritePresenter)
    }
  }
}
