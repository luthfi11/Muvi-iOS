//
//  MovieGrid.swift
//  Common
//
//  Created by Dans Multipro on 19/09/21.
//

import SwiftUI
import SDWebImageSwiftUI
import Core

public struct MovieGrid: View {
  var movie: MovieModel
  
  public init (movie: MovieModel) {
    self.movie = movie
  }
  
  public var body: some View {
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

struct MovieGrid_Previews: PreviewProvider {
  static let movie = MovieModel(
    id: 1,
    title: "The Suicide Squad",
    releaseDate: "2021-07-28",
    posterPath: "/iCi4c4FvVdbaU1t8poH1gvzT6xM.jpg",
    backdropPath: "/jlGmlFOcfo8n5tURmhC7YVd4Iyy.jpg",
    popularity: 6286.069,
    voteAverage: 8.1,
    voteCount: 2767,
    overview: "Supervillains Harley Quinn, Bloodsport, Peacemaker and a collection of nutty cons at Belle Reve prison join the super-secret, super-shady Task Force X as they are dropped off at the remote, enemy-infused island of Corto Maltese.",
    language: "en"
  )
  static var previews: some View {
    MovieGrid(movie: movie)
  }
}
