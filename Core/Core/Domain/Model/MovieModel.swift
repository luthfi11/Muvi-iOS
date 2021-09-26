//
//  MovieModel.swift
//  Core
//
//  Created by Dans Multipro on 20/09/21.
//

import Foundation

public struct MovieModel: Equatable, Identifiable {
  public let id: Int
  public let title: String
  public let releaseDate: String?
  public let posterPath: String?
  public let backdropPath: String?
  public let popularity: Double?
  public var voteAverage: Double?
  public let voteCount: Int?
  public let overview: String?
  public let language: String?
  public let favorite: Bool
  
  public init(
    id: Int,
    title: String,
    releaseDate: String?,
    posterPath: String?,
    backdropPath: String?,
    popularity: Double?,
    voteAverage: Double?,
    voteCount: Int?,
    overview: String?,
    language: String?,
    favorite: Bool = false
  ) {
    self.id = id
    self.title = title
    self.releaseDate = releaseDate
    self.posterPath = posterPath
    self.backdropPath = backdropPath
    self.popularity = popularity
    self.voteAverage = voteAverage
    self.voteCount = voteCount
    self.overview = overview
    self.language = language
    self.favorite = favorite
  }
}
