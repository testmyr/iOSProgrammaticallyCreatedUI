//
//  Coordinator.swift
//  RedditSample
//
//  Created by sdk on 7/2/19.
//  Copyright © 2019 Sdk. All rights reserved.
//

import Foundation
import UIKit

class Coordinator {
    let window: UIWindow?
    
    lazy var rootNavigationController: UINavigationController = {
        let postsVC: PostsVC = PostsVC(viewModel: postsViewModel)
        postsViewModel.viewDelegate = postsVC
        return UINavigationController(rootViewController: postsVC)
    }()
    lazy var postsViewModel: PostsModelView = {
        let viewModel = PostsModelView()
        viewModel.coordinatorDelegate = self
        return viewModel
    }()
    //var postViewModel
    
    
    init(window: UIWindow?) {
        self.window = window
    }
    
    func start() {
        guard let window = window else {
            return
        }
        window.rootViewController = rootNavigationController
        window.makeKeyAndVisible()
    }
}

extension Coordinator: PostsViewModelCoordinatorDelegate {
    func didSelectRow(_ row: Int) {
        if let selectedPost = postsViewModel.selectedPost {
        }
    }
}
