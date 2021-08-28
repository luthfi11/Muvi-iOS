//
//  MovieDetailView.swift
//  Muvi
//
//  Created by Dans Multipro on 28/08/21.
//

import SwiftUI
import SDWebImageSwiftUI

struct MovieDetailView: View {
  @ObservedObject var presenter: MovieDetailPresenter
  
  var body: some View {
    ScrollView(.vertical) {
      backdrop
      poster
      VStack {
        title
        content
      }
      .offset(y: -95)
    }
  }
}

extension MovieDetailView {
  var backdrop: some View {
    WebImage(url: URL(string: "\(Endpoints.Gets.backdrop.url)/\(presenter.movie.backdropPath ?? "-")" ))
      .resizable()
      .scaledToFill()
      .shadow(radius: 10)
  }
  
  var poster: some View {
    ZStack {
      WebImage(url: URL(string: "\(Endpoints.Gets.image.url)/\(presenter.movie.posterPath ?? "-")" ))
        .resizable()
        .indicator(.activity)
        .transition(.fade(duration: 0.5))
        .scaledToFit()
        .frame(width: 150, height: 225, alignment: .leading)
        .cornerRadius(8)
        .overlay(RoundedRectangle(cornerRadius: 8)
        .stroke(Color.white, lineWidth: 2))
        .shadow(radius: 5)
    }
    .offset(y: -100)
  }
  
  var title: some View {
    VStack {
      Text(presenter.movie.title)
        .font(.title)
        .fontWeight(.bold)
      Text(presenter.movie.overview ?? "Unknown")
        .font(.callout)
        .italic()
        .multilineTextAlignment(.center)
        .padding(.top, 1)
        .fixedSize(horizontal: false, vertical: true)
    }
    .padding(.horizontal, 16)
  }
  
  var content: some View {
    VStack(alignment: .leading) {
      HStack {
        Image(systemName: "calendar")
          .foregroundColor(.gray)
        VStack(alignment: .leading) {
          Text("Release Date")
            .font(.footnote)
            .fontWeight(.light)
          Text(DateFormat.format(date: presenter.movie.releaseDate ?? ""))
            .font(.headline)
            .fontWeight(.medium)
        }
      }
      
      HStack {
        Image(systemName: "star")
          .foregroundColor(.gray)
        VStack(alignment: .leading) {
          Text("Rating")
            .font(.footnote)
            .fontWeight(.light)
          Text("\(String(presenter.movie.voteAverage ?? 0)) (\(String(presenter.movie.voteCount ?? 0)) votes)")
            .font(.headline)
            .fontWeight(.medium)
        }
      }
      .padding(.top, 10)
      
      HStack {
        Image(systemName: "person")
          .foregroundColor(.gray)
        VStack(alignment: .leading) {
          Text("Popularity")
            .font(.footnote)
            .fontWeight(.light)
          Text("\(String(presenter.movie.popularity ?? 0))")
            .font(.headline)
            .fontWeight(.medium)
        }
      }
      .padding(.top, 10)
      
      HStack {
        Image(systemName: "flag")
          .foregroundColor(.gray)
        VStack(alignment: .leading) {
          Text("Original Language")
            .font(.footnote)
            .fontWeight(.light)
          Text(presenter.movie.language ?? "Unknown")
            .font(.headline)
            .fontWeight(.medium)
        }
      }
      .padding(.top, 10)
    }
    .frame(maxWidth: .infinity, alignment: .leading)
    .padding(16)
  }
}

struct MovieDetailView_Previews: PreviewProvider {
  static var previews: some View {
    let movie = MovieModel(
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
    let detailUseCase = Injection.init().provideDetail(movie: movie)
    let presenter = MovieDetailPresenter(detailUseCase: detailUseCase)
    MovieDetailView(presenter: presenter)
  }
}
