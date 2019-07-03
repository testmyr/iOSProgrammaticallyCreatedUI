//
//  SimpleWebService.swift
//  RedditSample
//
//  Created by sdk on 7/2/19.
//  Copyright © 2019 Sdk. All rights reserved.
//

import Foundation

class SimpleWebService {
    private let baseUrl = "https://www.reddit.com/r/all/top/"
    private let baseImageUrl = "https://b.thumbs.redditmedia.com"
    private let urlSuffixTopPosts = ".json"
    
    private var dataTasksOfThumbnails : [URLSessionDataTask] = []
    private let queue = DispatchQueue(label: "Serial queue for the dataTasksOfThumbnails accessing")
    
    private let pageSize = 10
    private var nextPageId: String?
    
    static let shared = SimpleWebService()
    private init() {
    }
    
    func getFirstTopPostsPage(withAftermathClosure aftermathClosure: @escaping (Bool, [Post]?) -> Void) {
        nextPageId = nil
        getNextTopPostsPage(withAftermathClosure: aftermathClosure)
    }
    
    func getNextTopPostsPage(withAftermathClosure aftermathClosure: @escaping (Bool, [Post]?) -> Void) {
        let topPostsUrlString = baseUrl + urlSuffixTopPosts
        var url = URLComponents(string: topPostsUrlString)!
        
        url.queryItems = [
            URLQueryItem(name: "t", value: "all"),
            URLQueryItem(name: "limit", value: String(pageSize))
        ]
        if let nextPageId = nextPageId {
            url.queryItems?.append(URLQueryItem(name: "after", value: String(nextPageId)))
            
        }
        guard let finalUrl = url.url else {return}
        let task = URLSession.shared.dataTask(with: finalUrl) { (data, response, error) in
            var success = false
            defer {
                if !success {
                    aftermathClosure(false, nil)
                }
            }
            guard let dataResponse = data, error == nil else {
                print(error?.localizedDescription ?? "Oops..")
                return
            }
            do {
                let jsonResponse = try JSONSerialization.jsonObject(with: dataResponse, options: [])
                guard let jsonRootDictionary = jsonResponse as? [String: Any] else {
                    return
                }
                guard let jsonDataDictionary = jsonRootDictionary["data"] as? [String: Any] else {
                    return
                }
                guard let jsonArray = jsonDataDictionary["children"] as? [[String: Any]] else {
                    return
                }
                self.nextPageId = jsonDataDictionary["after"] as? String
                var model = [Post]()
                model = jsonArray.compactMap{ (dictionary) in
                    return Post(dictionary["data"] as? [String: Any])
                }
                success = true
                aftermathClosure(true, model)
            } catch let parsingError {
                print("Error", parsingError)
            }
        }
        task.resume()
    }
    
    func getThumbnail(withPath imagePath: String, withAftermathClosure aftermathClosure: @escaping (Bool, Data?) -> Void) {
        let imageUrl = URL(string: baseImageUrl + imagePath)!
        if dataTasksOfThumbnails.index(where: { task in
            task.originalRequest?.url == imageUrl
        }) != nil {
            return
        }
        weak var taskRef: URLSessionDataTask!
        let task = URLSession.shared.dataTask(with: imageUrl) { [unowned self] (data, response, error) in
            var success = false
            defer {
                if !success {
                    aftermathClosure(false, nil)
                }
            }
            guard let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil
                else {
                    return
            }
            success = true
            aftermathClosure(true, data)
            self.queue.sync {
                if taskRef != nil, let indexForRemoving = self.dataTasksOfThumbnails.firstIndex(where: {$0 === taskRef}) {
                    self.dataTasksOfThumbnails.remove(at: indexForRemoving)
                }
            }
        }
        taskRef = task
        task.resume()
        queue.sync {
            dataTasksOfThumbnails.append(task)
        }
    }
    
    func cancelGettingThumbnail(withPath imagePath: String) {
        let imageUrl = URL(string: baseImageUrl + imagePath)!
        queue.sync {
            guard let dataTaskIndex = dataTasksOfThumbnails.index(where: { task in
                task.originalRequest?.url == imageUrl
            }) else {
                return
            }
            dataTasksOfThumbnails[dataTaskIndex].cancel()
            dataTasksOfThumbnails.remove(at: dataTaskIndex)
        }
    }
    
    func getDetailedDescription(byPostID postID: String, withAftermathClosure aftermathClosure: @escaping (Bool, Post?) -> Void) {
        
    }
}
