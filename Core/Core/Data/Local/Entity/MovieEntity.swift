//
//  MovieEntity.swift
//  Core
//
//  Created by Dans Multipro on 21/09/21.
//

import Foundation
import RealmSwift

public class MovieEntity: Object {
  @objc dynamic var id: Int = 0
  @objc dynamic var title: String = ""
  @objc dynamic var releaseDate: String = ""
  @objc dynamic var posterPath: String = ""
  @objc dynamic var backdropPath: String = ""
  @objc dynamic var popularity: Double = 0
  @objc dynamic var voteAverage: Double = 0
  @objc dynamic var voteCount: Int = 0
  @objc dynamic var overview: String = ""
  @objc dynamic var language: String = ""
  @objc dynamic var favorite = false
  
  public override static func primaryKey() -> String? {
    return "id"
  }
}
