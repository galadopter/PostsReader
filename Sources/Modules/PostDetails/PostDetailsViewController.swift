//
//  PostDetailsViewController.swift
//  PostsReader
//
//  Created by Yan Schneider on 3.04.21.
//

import UIKit
import RxSwift

class PostDetailsViewController: UIViewController {
    
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var authorLabel: UILabel!
    @IBOutlet private weak var bodyLabel: UILabel!
    @IBOutlet private weak var commentsTableView: UITableView!
    
    private let viewModel: PostsDetailsViewModel
    private let post: Post
    private let bag = DisposeBag()
    
    init?(coder: NSCoder, post: Post) {
        self.post = post
        viewModel = PostsDetailsViewModel(post: post)
        
        super.init(coder: coder)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setup()
        bind()
    }
}

private extension PostDetailsViewController {
    
    func setup() {
        navigationItem.title = "Post Detail"
        titleLabel.text = post.title
        bodyLabel.text = post.body
    }
    
    func bind() {
        let output = viewModel.transform(input: .just(()))
        
        bag.insert([
            output.isLoading.drive(rx.isLoading),
            output.errors.emit(to: rx.error),
            
            output.user.map { "Created by: \($0.name)" }
                .drive(authorLabel.rx.text)
        ])
    }
}
