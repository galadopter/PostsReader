//
//  PostsViewController.swift
//  PostsReader
//
//  Created by Yan Schneider on 3.04.21.
//

import UIKit
import RxSwift

class PostsViewController: UIViewController {
    
    @IBOutlet private weak var tableView: UITableView!
    
    private let viewModel = PostsViewModel()
    private let bag = DisposeBag()
    
    private var selectedPost: Post?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
        bind()
    }
}

// MARK: Setup
private extension PostsViewController {
    
    func setup() {
        navigationItem.title = "Posts"
        tableView.register(PostCell.nib, forCellReuseIdentifier: PostCell.reuseIdentifier)
    }
    
    func bind() {
        let output = viewModel.transform(input: .just(()))
        
        bag.insert([
            output.isLoading.drive(rx.isLoading),
            output.errors.emit(to: rx.error),
            
            output.posts
                .drive(tableView.rx.items(cellIdentifier: PostCell.reuseIdentifier, cellType: PostCell.self)) { _, post, cell in
                    cell.configure(title: post.title, body: post.body)
                }
        ])
        
        internalBinding()
    }
    
    func internalBinding() {
        tableView.rx.modelSelected(Post.self).subscribe(onNext: { [weak self] post in
            self?.selectedPost = post
            self?.performSegue(withIdentifier: "FromPostsToPostDetailsSegue", sender: nil)
        }).disposed(by: bag)
    }
}

// MARK: Navigation
extension PostsViewController {
    
    @IBSegueAction
    func makePostDetailsViewController(coder: NSCoder, sender: Any?, segueIdentifier: String?) -> UIViewController? {
        selectedPost.flatMap {
            PostDetailsViewController(coder: coder, post: $0)
        }
    }
}
