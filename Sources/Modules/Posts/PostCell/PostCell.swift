//
//  PostCell.swift
//  PostsReader
//
//  Created by Yan Schneider on 3.04.21.
//

import UIKit

class PostCell: UITableViewCell {

    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var bodyLabel: UILabel!
    
    func configure(title: String, body: String) {
        titleLabel.text = title
        bodyLabel.text = body
    }
}
