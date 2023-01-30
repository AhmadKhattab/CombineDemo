//
//  Environment.swift
//  CombineDemo
//
//  Created by Ahmad Ashraf Khattab on 25/01/2023.
//

import Foundation
import CoreText

/// `Environment`  Contains BaseURL and API access token
///
enum Environment {
    // API base url
    static let apiBaseURL: URL = {
        guard let apiBaseURL = Bundle.main.object(forInfoDictionaryKey: PlistKeys.baseURL) as? String else {
            fatalError("ApiBaseURL must not be empty in plist")
        }
        guard let url = URL(string: "https://\(apiBaseURL)") else {
            fatalError("Root URL is invalid")
        }
        return url
    }()
    // Movies API Key
    static let moviesAPIKeyValue: String = {
        return "39124f42fcda5e6e4e22a9d602876810"
    }()
    
    static let moviePosterURL: URL = {
        guard let moviePosterURL = Bundle.main.object(forInfoDictionaryKey: PlistKeys.moviePosterURL) as? String else {
            fatalError("ApiBaseURL must not be empty in plist")
        }
        guard let url = URL(string: "https://\(moviePosterURL)") else {
            fatalError("Root URL is invalid")
        }
        return url
    }()
}
// MARK: - Plist Keys
private extension Environment {
    enum PlistKeys {
        static let baseURL = "SERVER_URL"
        static let moviesAPIKey = "MOVIES_API_KEY"
        static let moviePosterURL = "MOVIE_POSTER_URL"
    }
}
