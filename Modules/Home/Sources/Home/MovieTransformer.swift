//
//  File.swift
//  
//
//  Created by Dans Multipro on 10/09/21.
//

import Core

public struct MovieTransformer: Mapper {
  public typealias Response = [MovieResponse]
  public typealias Entity = [MovieModuleEntity]
  public typealias Domain = [MovieDomainModel]
  
  public init() {}
  
  public func transformResponseToEntity(response: [MovieResponse]) -> [MovieModuleEntity] {
    return response.map { result in
      let newMovie = MovieModuleEntity()
      newMovie.id = result.id
      newMovie.title = result.title
      newMovie.releaseDate = result.releaseDate ?? "Unknown"
      newMovie.posterPath = result.posterPath ?? "-"
      newMovie.backdropPath = result.backdropPath ?? "-"
      newMovie.popularity = result.popularity ?? 0
      newMovie.voteAverage = result.voteAverage ?? 0
      newMovie.voteCount = result.voteCount ?? 0
      newMovie.overview = result.overview ?? "Unknown"
      newMovie.language = result.language ?? "Unknown"
      return newMovie
    }
  }
  
  public func transformEntityToDomain(entity: [MovieModuleEntity]) -> [MovieDomainModel] {
    return entity.map { result in
      return MovieDomainModel(
        id: result.id,
        title: result.title,
        releaseDate: result.releaseDate,
        posterPath: result.posterPath,
        backdropPath: result.backdropPath,
        popularity: result.popularity,
        voteAverage: result.voteAverage,
        voteCount: result.voteCount,
        overview: result.overview,
        language: result.language,
        favorite: result.favorite
      )
    }
  }
}
