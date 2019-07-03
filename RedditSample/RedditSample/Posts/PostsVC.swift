//
//  PostsVC.swift
//  RedditSample
//
//  Created by sdk on 7/2/19.
//  Copyright © 2019 Sdk. All rights reserved.
//

import UIKit

class PostsVC: UIViewController {
    
    var tblViewPosts: UITableView!
    let cellId = "PostTableViewCell"
    
    fileprivate var viewModel: PostsViewModelProtocol!
    
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
        setUpSubviews()
    }
    
    private func setUpSubviews() {
        tblViewPosts = UITableView()
        tblViewPosts.backgroundColor = .black
        tblViewPosts.delegate = self
        tblViewPosts.dataSource = self
        self.view.addSubview(tblViewPosts)
        tblViewPosts.rowHeight = UITableView.automaticDimension
        tblViewPosts.register(PostTableViewCell.self, forCellReuseIdentifier: cellId)
        tblViewPosts.translatesAutoresizingMaskIntoConstraints = false
        tblViewPosts.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        tblViewPosts.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        tblViewPosts.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        tblViewPosts.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        let refreshControl = UIRefreshControl()
        refreshControl.tintColor = .white
        refreshControl.backgroundColor = .darkGray
        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
        tblViewPosts.addSubview(refreshControl)
    }
    
    @objc private func refresh(refreshControl: UIRefreshControl) {
        viewModel.refreshData()
        refreshControl.endRefreshing()
        
    }
}

extension PostsVC: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfPosts()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! PostTableViewCell
        cell.post = viewModel.postFor(rowAtIndex: indexPath.row)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.didSelectRow(indexPath.row)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        var cellHeight: CGFloat
        let height = tableView.frame.height
        let width = tableView.frame.width
        let coefficient: CGFloat = 0.3
        if UIDevice.current.userInterfaceIdiom == .phone {
            if width > height {
                cellHeight = height * coefficient
            } else {
                cellHeight = width * coefficient * CGFloat(1.2)
            }
        } else {
            return 50//to do
        }
        return cellHeight
    }
}

extension PostsVC: PostsViewModelViewDelegate {
    func updateAllRows() {
        DispatchQueue.main.async {
            self.tblViewPosts.reloadData()
        }
    }
    
    func updateRows(with: [IndexPath]) {
        
    }
}
