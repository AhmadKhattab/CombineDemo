//
//  FetchPostsUseCaseProtocol.swift
//  CombineDemo
//
//  Created by Ahmad Ashraf Khattab on 25/01/2023.
//

import Foundation
import Combine

protocol FetchMoviesUseCaseProtocol {
    func fetchMovies() -> AnyPublisher<MoviesResponseModel, NetworkError>
}
