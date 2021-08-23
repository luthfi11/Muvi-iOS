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

    WindowGroup {
      ContentView().environmentObject(homePresenter)
    }
  }
}
