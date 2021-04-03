//
//  PostDetailsViewController.swift
//  PostsReader
//
//  Created by Yan Schneider on 3.04.21.
//

import UIKit

class PostDetailsViewController: UIViewController {
    
    private let post: Post
    
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var authorLabel: UILabel!
    @IBOutlet private weak var bodyLabel: UILabel!
    @IBOutlet private weak var commentsTableView: UITableView!
    
    init?(coder: NSCoder, post: Post) {
        self.post = post
        
        super.init(coder: coder)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setup()
    }
}

private extension PostDetailsViewController {
    
    func setup() {
        navigationItem.title = "Post Detail"
        titleLabel.text = post.title
        bodyLabel.text = post.body
    }
}
