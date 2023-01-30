//
//  PostTableViewCell.swift
//  CombineDemo
//
//  Created by Ahmad Ashraf Khattab on 24/01/2023.
//

import UIKit

protocol ConfigurableMovieCell {
    func configureCell(with model: MovieViewModel)
}

class MovieTableViewCell: UITableViewCell, NibLoadable {
    // MARK: - Outlet(s)
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var posterImageView: UIImageView!
    @IBOutlet private weak var bodyLabel: UILabel!
    // MARK: - Lifecycle Method(s)
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}
// MARK: - Configure cell with post data model
extension MovieTableViewCell: ConfigurableMovieCell {
    func configureCell(with model: MovieViewModel) {
        titleLabel.text = model.title
        bodyLabel.text = model.overview
        setupMoviePoster(using: model.posterURL)
    }
}
extension MovieTableViewCell {
    private func setupMoviePoster(using url: URL) {
        posterImageView.downloaded(from: url, contentMode: .scaleAspectFill)
    }
}
