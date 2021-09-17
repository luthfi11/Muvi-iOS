//
//  File.swift
//  
//
//  Created by Dans Multipro on 10/09/21.
//

import Core
import Combine
import Alamofire
import Foundation

public struct GetHomeRemoteDataSource: DataSource {
  public typealias Request = Any
  public typealias Response = [MovieResponse]
  
  private let _endpoint: String
  
  public init(endpoint: String) {
    _endpoint = endpoint
  }
  
  public func execute(request: Any?) -> AnyPublisher<[MovieResponse], Error> {
    return Future<[MovieResponse], Error> { completion in
      if let url = URL(string: _endpoint) {
        AF.request(url)
          .validate()
          .responseDecodable(of: MoviesResponse.self) { response in
            switch response.result {
            case .success(let value):
              completion(.success(value.results))
            case .failure:
              completion(.failure(URLError.invalidResponse))
            }
          }
      }
    }.eraseToAnyPublisher()
  }
}
