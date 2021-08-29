//
//  Injection.swift
//  Muvi
//
//  Created by Dans Multipro on 22/08/21.
//

import Foundation
import RealmSwift

final class Injection: NSObject {
  
  private func provideRepository() -> MovieRepositoryProtocol {
    let realm = try? Realm()

    let local: LocalDataSource = LocalDataSource.sharedInstance(realm)
    let remote: RemoteDataSource = RemoteDataSource.sharedInstance

    return MovieRepository.sharedInstance(local, remote)
  }

  func provideHome() -> HomeUseCase {
    let repository = provideRepository()
    return HomeInteractor(repository: repository)
  }

  func provideDetail(movie: MovieModel) -> DetailUseCase {
    let repository = provideRepository()
    return DetailInteractor(repository: repository, movie: movie)
  }
  
  func provideFavorite() -> FavoriteUseCase {
    let repository = provideRepository()
    return FavoriteInteractor(repository: repository)
  }
}
