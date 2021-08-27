//
//  ContentView.swift
//  Muvi
//
//  Created by Dans Multipro on 15/08/21.
//

import SwiftUI

struct ContentView: View {
  @EnvironmentObject var homePresenter: HomePresenter
  
  var body: some View {
    TabView {
      HomeView(presenter: homePresenter)
        .tabItem {
          Label("Home", systemImage: "house.fill")
        }
      AboutView()
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

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
