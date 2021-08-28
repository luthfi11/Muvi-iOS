//
//  AboutView.swift
//  Muvi
//
//  Created by Dans Multipro on 27/08/21.
//

import SwiftUI

struct AboutView: View {
  var body: some View {
    ScrollView {
      Image("Profile")
        .resizable()
        .scaledToFill()
        .frame(width: 200, height: 200, alignment: .top)
        .clipped()
        .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
        .padding(.top, 30)
      Text("Luthfi Alfarisi")
        .font(.title)
        .padding(.top, 10)
      Text("Mobile Developer")
      Text("luthfialfarizi98@gmail.com")
        .foregroundColor(.gray)
        .padding(.top, 1)
    }
    .navigationBarTitle("About Me", displayMode: .inline)
  }
}

struct AboutView_Previews: PreviewProvider {
  static var previews: some View {
    AboutView()
  }
}
