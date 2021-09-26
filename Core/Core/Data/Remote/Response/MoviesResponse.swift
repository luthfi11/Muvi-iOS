//
//  MoviesResponse.swift
//  Core
//
//  Created by Dans Multipro on 24/09/21.
//

import Foundation

public struct MovieResponse: Decodable {
  let id: Int
  let title: String
  let releaseDate: String?
  let posterPath: String?
  let backdropPath: String?
  let popularity: Double?
  let voteAverage: Double?
  let voteCount: Int?
  let overview: String?
  let language: String?
  
  private enum CodingKeys: String, CodingKey {
    case id
    case title
    case releaseDate = "release_date"
    case posterPath = "poster_path"
    case backdropPath = "backdrop_path"
    case popularity
    case voteAverage = "vote_average"
    case voteCount = "vote_count"
    case overview
    case language = "original_language"
  }
}

public struct MoviesResponse: Decodable {
  let results: [MovieResponse]
}
