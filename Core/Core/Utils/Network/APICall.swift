//
//  APICall.swift
//  Core
//
//  Created by Dans Multipro on 24/09/21.
//

import Foundation

public struct API {
  static let baseUrl = "https://api.themoviedb.org/3/"
  static let apiKey = "60bf79a20ebb1e7e480ffe0d5c1bb2eb"
  static let imageBaseUrl = "https://image.tmdb.org/t/p/"
}

public protocol Endpoint {
  var url: String { get }
}

public enum Endpoints {
  public enum Gets: Endpoint {
    case movies
    case image
    case backdrop
    case search
    
    public var url: String {
      switch self {
      case .movies: return "\(API.baseUrl)movie/now_playing?api_key=\(API.apiKey)"
      case .image: return "\(API.imageBaseUrl)w185"
      case .backdrop: return "\(API.imageBaseUrl)w780"
      case .search: return "\(API.baseUrl)search/movie?api_key=\(API.apiKey)&query="
      }
    }
  }
}
