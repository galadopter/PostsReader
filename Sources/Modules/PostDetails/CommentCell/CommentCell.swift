//
//  CommentCell.swift
//  PostsReader
//
//  Created by Yan Schneider on 4.04.21.
//

import UIKit

class CommentCell: UITableViewCell {

    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var authorLabel: UILabel!
    @IBOutlet private weak var bodyLabel: UILabel!
    
    func configure(title: String, authorName: String, body: String) {
        titleLabel.text = title
        authorLabel.text = "Posted by: \(authorName)"
        bodyLabel.text = body
    }
}
