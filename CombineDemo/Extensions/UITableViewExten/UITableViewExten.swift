//
//  UITableViewExten.swift
//  CombineDemo
//
//  Created by Ahmad Ashraf Khattab on 24/01/2023.
//

import UIKit

extension UITableView {
    func register<Cell: UITableViewCell>(_: Cell.Type) where Cell: NibLoadable {
        self.register(UINib(nibName: Cell.nibName, bundle: nil), forCellReuseIdentifier: Cell.reuseIdentifier)
    }
    func dequeueReusableCell<Cell: UITableViewCell>(for indexPath: IndexPath) -> Cell {
        guard let cell = self.dequeueReusableCell(withIdentifier: Cell.reuseIdentifier, for: indexPath) as? Cell else {
            fatalError("Could not dequeue cell with identifier: \(Cell.reuseIdentifier)")
        }
        return cell
    }
}
extension UITableViewCell {
    static var reuseIdentifier: String {
        String(describing: self)
    }
}
