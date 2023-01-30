//
//  NetworkService.swift
//  CombineDemo
//
//  Created by Ahmad Ashraf Khattab on 24/01/2023.
//

import Foundation
import Combine

class NetworkService: NetworkServiceProtocol {    
    // MARK: - Properties
    private let session: URLSession
    // MARK: - Initializer(s)
    init(session: URLSession = URLSession.shared) {
        self.session = session
    }
    // MARK: - Method(s)
    
    /// Make API request to specific end point
    /// - Returns: AnyPublisher to emit the received data from network request
    func fetch<T: Codable, E: EndPointType>(endPoint: E) -> AnyPublisher<T, NetworkError> {
        let urlRequest = buildRequest(from: endPoint)
        return session
            .dataTaskPublisher(for: urlRequest)
            .tryMap { (data, response) in
                guard let httpResponse = response as? HTTPURLResponse else {
                    throw NetworkError.unacceptableStatusCode
                }
                guard (200..<300) ~= httpResponse.statusCode else {
                    throw NetworkError.init(from: httpResponse.statusCode)
                }
                return data
            }
            .decode(type: T.self, decoder: JSONDecoder())
            .mapError { error -> NetworkError in
                if let receivedError = error as? NetworkError {
                    return receivedError
                } else if error is DecodingError {
                    return NetworkError.unableToDecode
                } else {
                    return NetworkError.unacceptableStatusCode
                }
            }
            .eraseToAnyPublisher()
    }
}
// MARK: - Private Handlers
private extension NetworkService {
    /// Converting `EndPointType` to `URLRequest`
    /// - Parameter route: End point to execute that conform to `EndPointType`
    /// - Returns: URLRequest
    func buildRequest(from route: EndPointType) -> URLRequest {
        var urlComponents = URLComponents(url: route.baseURL, resolvingAgainstBaseURL: false)
        urlComponents?.path = route.path
        urlComponents?.queryItems = []
        route.queryParams?.forEach({ queryParam in
            urlComponents?.queryItems?.append(URLQueryItem(name: queryParam.key, value: queryParam.value))
        })
        
        var request = URLRequest(url: (urlComponents?.url)!,
                                 cachePolicy: .reloadIgnoringLocalAndRemoteCacheData,
                                 timeoutInterval: 10.0)
        
        request.httpMethod = route.httpMethod.rawValue
        switch route.task {
        case .request:
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            self.addAdditionalHeaders(route.headers, request: &request)
        }
        return request
    }
    /// Add additional headers to request
    /// - Parameters:
    ///   - additionalHeaders: Headers need to add
    ///   - request: URL request
    func addAdditionalHeaders(_ additionalHeaders: HTTPHeaders?, request: inout URLRequest) {
        guard let headers = additionalHeaders else { return }
        for (key, value) in headers {
            request.setValue(value, forHTTPHeaderField: key)
        }
    }
}
