//
//  MuviApp.swift
//  Muvi
//
//  Created by Dans Multipro on 15/08/21.
//

import SwiftUI
import UIKit
import RealmSwift
import Core
import Home

class AppDelegate: NSObject, UIApplicationDelegate {
  static var originalAppDelegate: AppDelegate!
  var realm: Realm!
  
  func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil
  ) -> Bool {
    AppDelegate.originalAppDelegate = self
    realm = try! Realm()
    return true
  }
}

@main
struct MuviApp: SwiftUI.App {
  @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
  
  var body: some Scene {
    
    let homeUseCase: Interactor<
      Any,
      [MovieDomainModel],
      GetHomeRepository<
        GetHomeLocalDataSource,
        GetHomeRemoteDataSource,
        MovieTransformer>
    > = Injection.init().provideHome()
    let homePresenter = GetListPresenter(useCase: homeUseCase)

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
