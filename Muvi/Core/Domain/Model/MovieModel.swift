//
//  MovieModel.swift
//  Muvi
//
//  Created by Dans Multipro on 15/08/21.
//

import Foundation

struct MovieModel: Equatable, Identifiable {
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
}
