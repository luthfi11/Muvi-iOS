//
//  RemoteDataSource.swift
//  Core
//
//  Created by Dans Multipro on 24/09/21.
//

import Foundation
import Alamofire
import Combine

public protocol RemoteDataSourceProtocol: AnyObject {
  func getMovies() -> AnyPublisher<[MovieResponse], Error>
  func searchMovies(by title: String) -> AnyPublisher<[MovieResponse], Error>
}

public final class RemoteDataSource: NSObject {
  private override init() { }
  public static let sharedInstance: RemoteDataSource = RemoteDataSource()
}

extension RemoteDataSource: RemoteDataSourceProtocol {
  
  public func getMovies() -> AnyPublisher<[MovieResponse], Error> {
    return Future<[MovieResponse], Error> { completion in
      if let url = URL(string: Endpoints.Gets.movies.url) {
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
  
  public func searchMovies(by title: String) -> AnyPublisher<[MovieResponse], Error> {
    return Future<[MovieResponse], Error> { completion in
      if let url = URL(string: Endpoints.Gets.search.url + title) {
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
