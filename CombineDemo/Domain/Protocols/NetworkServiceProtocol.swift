//
//  NetworkServiceProtocol.swift
//  CombineDemo
//
//  Created by Ahmad Ashraf Khattab on 24/01/2023.
//

import Foundation
import Combine

protocol NetworkServiceProtocol {
    func fetch<T, E>(endPoint: E) -> AnyPublisher<T, NetworkError> where T: Codable, E: EndPointType
}
