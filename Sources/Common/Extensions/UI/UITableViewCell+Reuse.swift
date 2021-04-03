//
//  UITableViewCell+Reuse.swift
//  PostsReader
//
//  Created by Yan Schneider on 3.04.21.
//

import UIKit

public extension UITableViewCell {
    
    static var reuseIdentifier: String {
        String(describing: self)
    }

    static var nib: UINib {
        UINib(nibName: reuseIdentifier, bundle: Bundle(for: self))
    }
}
