//
//  MovieGrid.swift
//  Muvi
//
//  Created by Dans Multipro on 22/08/21.
//

import SwiftUI
import SDWebImageSwiftUI
import Core
import Home

struct MovieGrid: View {
  var movie: MovieDomainModel
  var body: some View {
    VStack {
      ZStack(alignment: .topTrailing) {
        movieImage
        rating
      }
      content
    }
    .frame(maxWidth: .infinity)
    .cornerRadius(8)
    .overlay(
      RoundedRectangle(cornerRadius: 8)
        .stroke(Color.gray, lineWidth: 0.2)
    )
    .padding(
      EdgeInsets(
        top: 10,
        leading: 5,
        bottom: 0,
        trailing: 5
      )
    )
  }
}

extension MovieGrid {
  var movieImage: some View {
    WebImage(url: URL(string: "\(Endpoints.Gets.image.url)/\(movie.posterPath ?? "-")" ))
      .resizable()
  }
  
  var rating: some View {
    HStack {
      Image(systemName: "star.fill")
        .foregroundColor(.yellow)
      Text(String(movie.voteAverage ?? 0))
        .foregroundColor(.yellow)
    }
    .padding(10)
    .background(Color.black)
  }

  var content: some View {
    VStack {
      Text(movie.title)
        .fontWeight(.medium)
        .padding(.horizontal, 10)
        .lineLimit(1)
      Text(DateFormat.format(date: movie.releaseDate ?? "-"))
        .fontWeight(.light)
        .padding(.horizontal, 10)
        .padding(.bottom, 10)
        .foregroundColor(.gray)
        .font(.caption)
    }
  }
}
