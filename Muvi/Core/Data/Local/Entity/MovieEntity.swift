//
//  GameEntity.swift
//  Muvi
//
//  Created by Dans Multipro on 15/08/21.
//

import Foundation
import RealmSwift

class MovieEntity: Object {
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
  
  override static func primaryKey() -> String? {
    return "id"
  }
}
