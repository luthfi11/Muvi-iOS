//
//  File.swift
//  
//
//  Created by Dans Multipro on 10/09/21.
//

import Foundation

public struct MovieDomainModel: Equatable, Identifiable {
  public var id: Int
  public var title: String
  public var releaseDate: String?
  public var posterPath: String?
  public var backdropPath: String?
  public var popularity: Double?
  public var voteAverage: Double?
  public var voteCount: Int?
  public var overview: String?
  public var language: String?
  public var favorite: Bool = false
}
