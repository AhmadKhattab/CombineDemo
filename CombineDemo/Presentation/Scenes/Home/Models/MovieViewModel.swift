//
//  MovieViewModel.swift
//  CombineDemo
//
//  Created by Ahmad Ashraf Khattab on 25/01/2023.
//

import Foundation

struct MovieViewModel {
    let title: String
    let overview: String
    let posterPath: String
    var posterURL: URL {
        let moviePosterEndPoint = MoviePosterEndPoint.getMoviePoster
        let url = moviePosterEndPoint.baseURL
        let configuredURL = url.appendingPathComponent(moviePosterEndPoint.path + posterPath)
        return configuredURL
    }
}

extension MovieViewModel {
    init(from movieModel: MovieModel) {
        title = movieModel.originalTitle
        overview = movieModel.overview
        posterPath = movieModel.posterPath
    }
}

typealias Movies = [MovieViewModel]
