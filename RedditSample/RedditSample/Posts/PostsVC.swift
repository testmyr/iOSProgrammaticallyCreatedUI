//
//  PostsVC.swift
//  RedditSample
//
//  Created by sdk on 7/2/19.
//  Copyright © 2019 Sdk. All rights reserved.
//

import UIKit

class PostsVC: UIViewController {
    
    private var viewModel: PostsViewModelProtocol! {
        didSet {
            viewModel.viewDelegate = self
        }
    }
    
    
    init(viewModel: PostsViewModelProtocol) {
        super.init(nibName: nil, bundle: nil)
        self.viewModel = viewModel
    }
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("Never will happen")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Reddit Posts"
        self.view.backgroundColor = UIColor.black

        // Do any additional setup after loading the view.
    }

}

extension PostsVC: PostsViewModelViewDelegate {
    func updateView() {
        
    }
    
    func updateRows(with: [IndexPath]) {
        
    }
    
    
}
