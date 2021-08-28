//
//  APICall.swift
//  Muvi
//
//  Created by Dans Multipro on 15/08/21.
//

import Foundation

struct API {
  static let baseUrl = "https://api.themoviedb.org/3/"
  static let apiKey = "60bf79a20ebb1e7e480ffe0d5c1bb2eb"
  static let imageBaseUrl = "https://image.tmdb.org/t/p/"
}

protocol Endpoint {
  var url: String { get }
}

enum Endpoints {
  enum Gets: Endpoint {
    case movies
    case image
    case backdrop
    
    public var url: String {
      switch self {
      case .movies: return "\(API.baseUrl)movie/now_playing?api_key=\(API.apiKey)"
      case .image: return "\(API.imageBaseUrl)w185"
      case .backdrop: return "\(API.imageBaseUrl)w780"
      }
    }
  }
}
