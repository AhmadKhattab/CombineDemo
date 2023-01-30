//
//  MoviesViewController.swift
//  CombineDemo
//
//  Created by Ahmad Ashraf Khattab on 24/01/2023.
//

import UIKit
import Combine

class MoviesViewController: UIViewController {
    // MARK: - Outlet(s)
    @IBOutlet private weak var tableView: UITableView!
    // MARK: - Properties
    private let viewModel: MoviesViewModelProtocol
    private var subscriptions = Set<AnyCancellable>()
    // MARK: - Lifecycle Method(s)
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        configureBinding()
        viewModel.fetchMovies()
    }
    // MARK: - Initializer(s)
    init(viewModel: MoviesViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
// MARK: - Setup Views
private extension MoviesViewController {
    func setupViews() {
        setupTitle()
        setupTableView()
    }
    func setupTitle() {
        navigationItem.title = Constants.pageName
    }
    func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        registerTableViewCell()
    }
    func registerTableViewCell() {
        tableView.register(MovieTableViewCell.self)
    }
}
// MARK: - Configure Binding
private extension MoviesViewController {
    func configureBinding() {
        bindOnReloadMoviesData()
        bindOnReceivingError()
    }
    func bindOnReloadMoviesData() {
        viewModel.reloadPublisher
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                self?.tableView.reloadData()
            }
            .store(in: &subscriptions)
    }
    func bindOnReceivingError() {
        viewModel.errorSubject
            .receive(on: DispatchQueue.main)
            .sink { [weak self] errorMessage in
                self?.showErrorAlert(with: errorMessage)
            }
            .store(in: &subscriptions)
    }
}
// MARK: - Setup Posts Table View Delegates
extension MoviesViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.moviesCount
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: MovieTableViewCell = tableView.dequeueReusableCell(for: indexPath)
        viewModel.configureCell(cell, at: indexPath.row)
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return Constants.cellHeight
    }
}
// MARK: - Show error alert
private extension MoviesViewController {
    func showErrorAlert(with errorMessage: String) {
        let alert = UIAlertController(title: Constants.errorTitle, message: errorMessage, preferredStyle: .alert)
        let dismissAction = UIAlertAction(title: Constants.dismissAlertActionText, style: .cancel)
        alert.addAction(dismissAction)
        self.present(alert, animated: true, completion: nil)
    }
}
// MARK: - Constants
private extension MoviesViewController {
    struct Constants {
        static let pageName: String = "Movies"
        static let errorTitle: String = "Technical Error"
        static let dismissAlertActionText: String = "Dismiss"
        static let cellHeight: CGFloat = 500.0
    }
}
