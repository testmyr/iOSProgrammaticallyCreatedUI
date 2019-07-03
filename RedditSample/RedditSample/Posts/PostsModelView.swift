//
//  PostsModelView.swift
//  RedditSample
//
//  Created by sdk on 7/2/19.
//  Copyright © 2019 Sdk. All rights reserved.
//

import UIKit

protocol PostsViewModelProtocol {
    var viewDelegate: PostsViewModelViewDelegate? { get set }
    
    func numberOfPosts() -> Int
    func postFor(rowAtIndex index: Int) -> Post
    func getNextPage()
    func refreshData()
    
    func fetchThumbnail(forIndex index: Int)
    func cancelFetchingThumbnail(forIndex index: Int)
    
    func dismissPost(withIndex index: Int)
    func dismissAllLoadedPosts(withIndex index: Int)
    
    func didSelectRow(_ row: Int)
}

protocol PostsViewModelViewDelegate: AnyObject {
    func updateAllRows()
    func updateRows(with: [IndexPath])
}

protocol PostsViewModelCoordinatorDelegate: AnyObject {
    func didSelectRow(_ row: Int)
}

class PostsModelView {
    var posts = [Post]()
    weak var coordinatorDelegate: PostsViewModelCoordinatorDelegate?
    weak var viewDelegate: PostsViewModelViewDelegate?
    
    var selectedPost: Post?
    
    init() {
        start()
    }
    
    func start() {
        SimpleWebService.shared.getTopPosts() { (isSuccess, result) in
            if isSuccess && result != nil {
                self.posts.append(contentsOf: result!)
                self.viewDelegate?.updateAllRows()
            }
        }
    }
}

extension PostsModelView: PostsViewModelProtocol {
    func numberOfPosts() -> Int {
        return posts.count
    }
    
    func postFor(rowAtIndex index: Int) -> Post {
        return posts[index]
    }
    
    func getNextPage() {
        
    }
    
    func refreshData() {
        SimpleWebService.shared.resetPaging()
        SimpleWebService.shared.getTopPosts() { (isSuccess, result) in
            if isSuccess && result != nil {
                self.posts = result!
                self.viewDelegate?.updateAllRows()
            }
        }
    }
    
    func fetchThumbnail(forIndex index: Int) {
        
    }
    
    func cancelFetchingThumbnail(forIndex index: Int) {
        
    }
    
    func dismissPost(withIndex index: Int) {
        
    }
    
    func dismissAllLoadedPosts(withIndex index: Int) {
        
    }
    
    func didSelectRow(_ row: Int) {
        
    }
    
    
}
