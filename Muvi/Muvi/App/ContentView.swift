//
//  ContentView.swift
//  Muvi
//
//  Created by Dans Multipro on 15/08/21.
//

import SwiftUI
import Home
import Favorite
import Search
import About

struct ContentView: View {

  @EnvironmentObject var homePresenter: HomePresenter
  @EnvironmentObject var searchMoviePresenter: SearchMoviePresenter
  @EnvironmentObject var favoritePresenter: FavoritePresenter
  
  var body: some View {
    TabView {
      NavigationView {
        HomeView(presenter: homePresenter)
      }
      .tabItem {
        Label("Home", systemImage: "house")
      }
      
      NavigationView {
        SearchMovieView(presenter: searchMoviePresenter)
      }
      .tabItem {
        Label("Search", systemImage: "magnifyingglass")
      }
      
      NavigationView {
        FavoriteView(presenter: favoritePresenter)
      }
      .tabItem {
        Label("Favorite", systemImage: "heart")
      }
      
      NavigationView {
        AboutView()
      }
      .tabItem {
        Label("About", systemImage: "person")
      }
    }
    .accentColor(.red)
    .onAppear {
      UITabBar.appearance().barTintColor = .white
    }
  }
}
