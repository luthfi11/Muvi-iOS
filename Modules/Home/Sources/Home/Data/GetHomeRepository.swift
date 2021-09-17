//
//  File.swift
//  
//
//  Created by Dans Multipro on 10/09/21.
//

import Core
import Combine

public struct GetHomeRepository<
  HomeLocalDataSource: LocalDataSource,
  RemoteDataSource: DataSource,
  Transformer: Mapper>: Repository
where
  HomeLocalDataSource.Response == MovieModuleEntity,
  RemoteDataSource.Response == [MovieResponse],
  Transformer.Response == [MovieResponse],
  Transformer.Entity == [MovieModuleEntity],
  Transformer.Domain == [MovieDomainModel] {
  
  public typealias Request = Any
  public typealias Response = [MovieDomainModel]
  
  private let _localDataSource: HomeLocalDataSource
  private let _remoteDataSource: RemoteDataSource
  private let _mapper: Transformer
  
  public init(
    localDataSource: HomeLocalDataSource,
    remoteDataSource: RemoteDataSource,
    mapper: Transformer) {
    
    _localDataSource = localDataSource
    _remoteDataSource = remoteDataSource
    _mapper = mapper
  }
  
  public func execute(request: Any?) -> AnyPublisher<[MovieDomainModel], Error> {
    return _localDataSource.list(request: nil)
      .flatMap { result -> AnyPublisher<[MovieDomainModel], Error> in
        if result.isEmpty {
          return _remoteDataSource.execute(request: nil)
            .map { _mapper.transformResponseToEntity(response: $0) }
            .catch { _ in _localDataSource.list(request: nil) }
            .flatMap { _localDataSource.add(entities: $0) }
            .filter { $0 }
            .flatMap { _ in _localDataSource.list(request: nil)
              .map { _mapper.transformEntityToDomain(entity: $0) }
            }
            .eraseToAnyPublisher()
        } else {
          return _localDataSource.list(request: nil)
            .map { _mapper.transformEntityToDomain(entity: $0) }
            .eraseToAnyPublisher()
        }
      }.eraseToAnyPublisher()
  }
}
