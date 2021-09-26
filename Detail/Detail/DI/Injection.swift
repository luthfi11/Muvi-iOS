//
//  Injection.swift
//  Detail
//
//  Created by Dans Multipro on 26/09/21.
//

import Foundation
import RealmSwift
import Core

public final class Injection: NSObject {
  
  private func provideRepository() -> MovieRepositoryProtocol {
    let realm = try? Realm()

    let local: LocalDataSource = LocalDataSource.sharedInstance(realm)
    let remote: RemoteDataSource = RemoteDataSource.sharedInstance

    return MovieRepository.sharedInstance(local, remote)
  }

  public func provideDetail(movie: MovieModel) -> DetailUseCase {
    let repository = provideRepository()
    return DetailInteractor(repository: repository, movie: movie)
  }
}
