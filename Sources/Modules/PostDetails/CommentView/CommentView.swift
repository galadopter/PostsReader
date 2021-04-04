//
//  CommentView.swift
//  PostsReader
//
//  Created by Yan Schneider on 4.04.21.
//

import UIKit

class CommentView: UIView {

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = .boldSystemFont(ofSize: 18)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let authorLabel: UILabel = {
        let label = UILabel()
        label.font = .italicSystemFont(ofSize: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var bodyLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        setup()
    }
    
    func configure(title: String, authorName: String, body: String) {
        titleLabel.text = title
        authorLabel.text = "Posted by: \(authorName)"
        bodyLabel.text = body
    }
}

private extension CommentView {
    
    func setup() {
        addSubview(titleLabel)
        addSubview(authorLabel)
        addSubview(bodyLabel)
        translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0),
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            authorLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0),
            authorLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0),
            authorLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 6),
            bodyLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0),
            bodyLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0),
            bodyLabel.topAnchor.constraint(equalTo: authorLabel.bottomAnchor, constant: 8),
            bottomAnchor.constraint(equalTo: bodyLabel.bottomAnchor, constant: 8)
        ])
    }
}
