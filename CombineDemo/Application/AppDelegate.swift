//
//  AppDelegate.swift
//  CombineDemo
//
//  Created by Ahmad Ashraf Khattab on 24/01/2023.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        startApp()
        return true
    }
    /// Set root view Controller
    ///
    private func startApp() {
        registerDependencies()
        let window = UIWindow(frame: UIScreen.main.bounds)
        let postsViewModel = DependencyContainer.shared.resolve(MoviesViewModelProtocol.self)!
        let postsViewController = MoviesViewController(viewModel: postsViewModel)
        let navigation = UINavigationController()
        navigation.viewControllers = [postsViewController]
        window.rootViewController = navigation
        self.window = window
        window.makeKeyAndVisible()
    }
    
    private func registerDependencies() {
        DependencyContainer.shared.register(type: NetworkServiceProtocol.self) {
            NetworkService()
        }
        DependencyContainer.shared.register(type: FetchMoviesUseCaseProtocol.self) {
            let networkService = DependencyContainer.shared.resolve(NetworkServiceProtocol.self)!
            return FetchMoviesUseCase(networkService: networkService)
        }
        DependencyContainer.shared.register(type: MoviesViewModelProtocol.self) {
            let fetchPostsUseCase = DependencyContainer.shared.resolve(FetchMoviesUseCaseProtocol.self)!
            return MoviesViewModel(with: fetchPostsUseCase)
        }
    }
}

