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
}

protocol Endpoint {
  var url: String { get }
}

enum Endpoints {
  enum Gets: Endpoint {
    case movies
    
    public var url: String {
      switch self {
      case .movies: return "\(API.baseUrl)movie/now_playing?api_key=\(API.apiKey)"
      }
    }
  }
}
