//
//  DependencyContainer.swift
//  CombineDemo
//
//  Created by Ahmad Ashraf Khattab on 24/01/2023.
//

import Foundation

/// `DependencyContainer` this class is used to register/resolve
/// the required dependencies
class DependencyContainer {
    static let shared = DependencyContainer()
    var factoryDict: [String: () -> Any] = [:]
    
    func register<Service>(type: Service.Type, _ factory: @escaping () -> Service) {
        factoryDict[String(describing: type.self)] = factory
    }
    func resolve<Service>(_ type: Service.Type) -> Service? {
        return factoryDict[String(describing: type.self)]?() as? Service
    }
}
