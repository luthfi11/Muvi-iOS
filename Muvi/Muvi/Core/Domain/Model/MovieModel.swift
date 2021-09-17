//
//  MovieModel.swift
//  Muvi
//
//  Created by Dans Multipro on 15/08/21.
//

import Foundation

struct MovieModel: Equatable, Identifiable {
  var id: Int
  var title: String
  var releaseDate: String?
  var posterPath: String?
  var backdropPath: String?
  var popularity: Double?
  var voteAverage: Double?
  var voteCount: Int?
  var overview: String?
  var language: String?
  var favorite: Bool = false
}
