//
//  MoviesEndPoint.swift
//  CombineDemo
//
//  Created by Ahmad Ashraf Khattab on 25/01/2023.
//

import Foundation

enum MoviesEndPoint {
    /// Get all movies
    case getMovies
}

// MARK: - PostsEndPoint + EndPoint
extension MoviesEndPoint: EndPointType {
    // Base URL
    var baseURL: URL {
        return Environment.apiBaseURL
    }
    // End point path
    var path: String {
        switch self {
        case .getMovies:
            return "/3/movie/popular"
        }
    }
    // Method
    var httpMethod: HTTPMethod {
        switch self {
        case .getMovies:
             return .get
        }
    }
    // Task
    var task: HTTPTask {
        switch self {
        case .getMovies:
            return .request
        }
    }
    // Header
    var headers: HTTPHeaders? {
        nil
    }
    // Query Params
    var queryParams: QueryParams? {
        let apiToken = Environment.moviesAPIKeyValue
        return ["api_key": apiToken]
    }
}
