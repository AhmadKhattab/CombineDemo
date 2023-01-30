//
//  MoviesViewModel.swift
//  CombineDemo
//
//  Created by Ahmad Ashraf Khattab on 24/01/2023.
//

import Foundation
import Combine

// MARK: - Requirement(s)
protocol MoviesViewModelInput {
    func fetchMovies()
    func configureCell(_ cell: ConfigurableMovieCell, at index: Int)
}
protocol MoviesViewModelOutput {
    var reloadPublisher: AnyPublisher<Void, Never> { get }
    var errorSubject: PassthroughSubject<String, Never> { get }
    var moviesCount: Int { get }
}
typealias MoviesViewModelProtocol = MoviesViewModelInput & MoviesViewModelOutput

class MoviesViewModel: MoviesViewModelProtocol {
    // MARK: - Properties
    private let fetchMoviesUseCase: FetchMoviesUseCaseProtocol
    private let moviesSubject: CurrentValueSubject<Movies, NetworkError>
    private var subscriptions = Set<AnyCancellable>()
    var reloadPublisher: AnyPublisher<Void, Never> {
        moviesSubject
            .map { _ in }
            .replaceError(with: ())
            .eraseToAnyPublisher()
    }
    let errorSubject: PassthroughSubject<String, Never>
    var moviesCount: Int { moviesSubject.value.count }
    // MARK: - Initializer(s)
    init(with useCase: FetchMoviesUseCaseProtocol) {
        fetchMoviesUseCase = useCase
        moviesSubject = CurrentValueSubject([])
        errorSubject = PassthroughSubject<String, Never>()
    }
    // MARK: - Method(s)
    func fetchMovies() {
        fetchMoviesUseCase.fetchMovies()
            .map(transform)
            .sink { [weak self] completion in
                if case .failure(let error) = completion {
                    self?.errorSubject.send(error.errorDescription ?? "")
                }
            } receiveValue: { [weak self] movies in
                self?.moviesSubject.send(movies)
            }
            .store(in: &subscriptions)
    }
    func configureCell(_ cell: ConfigurableMovieCell, at index: Int) {
        let movie = moviesSubject.value[index]
        cell.configureCell(with: movie)
    }
}
// MARK: - Transformation
private extension MoviesViewModel {
    /// transform movies received response to another model for viewing
    /// - Parameter moviesResponse: the received movies response
    /// - Returns: another movies model valid for viewing
    func transform(moviesResponse: MoviesResponseModel) -> Movies {
        var movies = [MovieViewModel]()
        moviesResponse.results.forEach { movie in
            movies.append(.init(from: movie))
        }
        return movies
    }
}



