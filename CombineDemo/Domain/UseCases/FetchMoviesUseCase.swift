//
//  FetchMoviesUseCase.swift
//  CombineDemo
//
//  Created by Ahmad Ashraf Khattab on 24/01/2023.
//

import Foundation
import Combine

/// `FetchMoviesUseCase` this class is used for fetching movies
class FetchMoviesUseCase: FetchMoviesUseCaseProtocol {
    // MARK: - Properties
    private let networkService: NetworkServiceProtocol
    // MARK: - Initializer(s)
    init(networkService: NetworkServiceProtocol) {
        self.networkService = networkService
    }
    // MARK: - Method(s)
    func fetchMovies() -> AnyPublisher<MoviesResponseModel, NetworkError> {
        return networkService.fetch(endPoint: MoviesEndPoint.getMovies)
    }
}
