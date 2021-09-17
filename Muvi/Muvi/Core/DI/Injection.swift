//
//  Injection.swift
//  Muvi
//
//  Created by Dans Multipro on 22/08/21.
//

import UIKit
import Core
import Home
import RealmSwift

final class Injection: NSObject {
  
  private func provideRepository() -> MovieRepositoryProtocol {
    let realm = try? Realm()

    let local: LocalDataSource = LocalDataSource.sharedInstance(realm)
    let remote: RemoteDataSource = RemoteDataSource.sharedInstance

    return MovieRepository.sharedInstance(local, remote)
  }
  
//  func provideHome() -> HomeUseCase {
//    let repository = provideRepository()
//    return HomeInteractor(repository: repository)
//  }
//
  func provideDetail(movie: MovieModel) -> DetailUseCase {
    let repository = provideRepository()
    return DetailInteractor(repository: repository, movie: movie)
  }

  func provideSearch() -> SearchUseCase {
    let repository = provideRepository()
    return SearchInteractor(repository: repository)
  }

  func provideFavorite() -> FavoriteUseCase {
    let repository = provideRepository()
    return FavoriteInteractor(repository: repository)
  }
  
  func provideHome<U: UseCase>() -> U where U.Request == Any, U.Response == [MovieDomainModel] {
    let local = GetHomeLocalDataSource(realm: AppDelegate.originalAppDelegate.realm)
    let remote = GetHomeRemoteDataSource(endpoint: Endpoints.Gets.movies.url)
    let mapper = MovieTransformer()

    let repository = GetHomeRepository(
      localDataSource: local,
      remoteDataSource: remote,
      mapper: mapper)

    return Interactor(repository: repository) as! U
  }
}
