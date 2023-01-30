//
//  MoviePosterEndPoint.swift
//  CombineDemo
//
//  Created by Ahmad Ashraf Khattab on 25/01/2023.
//

import Foundation


enum MoviePosterEndPoint {
    case getMoviePoster
}

extension MoviePosterEndPoint: EndPointType {
    var baseURL: URL {
        switch self {
        case .getMoviePoster:
            return Environment.moviePosterURL
        }
    }
    
    var path: String {
        switch self {
        case .getMoviePoster:
            return "/t/p/w500"
        }
    }
    
    var httpMethod: HTTPMethod {
        switch self {
        case .getMoviePoster:
            return .get
        }
    }
    
    var task: HTTPTask {
        switch self {
        case .getMoviePoster:
            return .request
        }
    }
    
    var headers: HTTPHeaders? {
        nil
    }
    
    var queryParams: QueryParams? {
        nil
    }
}
