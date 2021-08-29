//
//  ContentView.swift
//  Muvi
//
//  Created by Dans Multipro on 15/08/21.
//

import SwiftUI

struct ContentView: View {

  @EnvironmentObject var homePresenter: HomePresenter
  @EnvironmentObject var favoritePresenter: FavoritePresenter
  
  var body: some View {
    TabView {
      NavigationView {
        HomeView(presenter: homePresenter)
      }
      .tabItem {
        Label("Home", systemImage: "house.fill")
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
        Label("About", systemImage: "person.crop.circle")
      }
    }
    .accentColor(.red)
    .onAppear {
      UITabBar.appearance().barTintColor = .white
    }
  }
}
