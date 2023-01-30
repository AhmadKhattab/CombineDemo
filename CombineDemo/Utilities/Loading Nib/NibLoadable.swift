//
//  NibLoadable.swift
//  CombineDemo
//
//  Created by Ahmad Ashraf Khattab on 25/01/2023.
//

import UIKit

protocol NibLoadable: AnyObject {
    static var nibName: String { get }
}

extension NibLoadable where Self: UIView {
    static var nibName: String {
        return String(describing: self)
    }
}
