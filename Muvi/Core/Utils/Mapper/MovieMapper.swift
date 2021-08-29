//
//  MovieMapper.swift
//  Muvi
//
//  Created by Dans Multipro on 22/08/21.
//

final class MovieMapper {
  
  static func mapMovieResponsesToEntities(input movieResponses: [MovieResponse]) -> [MovieEntity] {
    return movieResponses.map { result in
      let newMovie = MovieEntity()
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
  
  static func mapMovieEntitiesToDomains(input movieEntities: [MovieEntity]) -> [MovieModel] {
    return movieEntities.map { result in
      return MovieModel(
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
  
  static func mapMovieResponsesToDomains(input movieResponses: [MovieResponse]) -> [MovieModel] {
    return movieResponses.map { result in
      return MovieModel(
        id: result.id,
        title: result.title,
        releaseDate: result.releaseDate,
        posterPath: result.posterPath,
        backdropPath: result.backdropPath,
        popularity: result.popularity,
        voteAverage: result.voteAverage,
        voteCount: result.voteCount,
        overview: result.overview,
        language: result.language
      )
    }
  }
  
  static func mapMovieEntityToDomains(input movieEntities: MovieEntity) -> MovieModel {
    return MovieModel(
      id: movieEntities.id,
      title: movieEntities.title,
      releaseDate: movieEntities.releaseDate,
      posterPath: movieEntities.posterPath,
      backdropPath: movieEntities.backdropPath,
      popularity: movieEntities.popularity,
      voteAverage: movieEntities.voteAverage,
      voteCount: movieEntities.voteCount,
      overview: movieEntities.overview,
      language: movieEntities.language,
      favorite: movieEntities.favorite
    )
  }
}
