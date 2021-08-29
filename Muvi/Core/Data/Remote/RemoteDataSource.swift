//
//  RemoteDataSource.swift
//  Muvi
//
//  Created by Dans Multipro on 15/08/21.
//

import Foundation
import Alamofire
import Combine

protocol RemoteDataSourceProtocol: AnyObject {
  func getMovies() -> AnyPublisher<[MovieResponse], Error>
  func searchMovies(by title: String) -> AnyPublisher<[MovieResponse], Error>
}

final class RemoteDataSource: NSObject {
  private override init() { }
  static let sharedInstance: RemoteDataSource = RemoteDataSource()
}

extension RemoteDataSource: RemoteDataSourceProtocol {
  
  func getMovies() -> AnyPublisher<[MovieResponse], Error> {
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
  
  func searchMovies(by title: String) -> AnyPublisher<[MovieResponse], Error> {
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
