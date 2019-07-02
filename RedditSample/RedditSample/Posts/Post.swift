//
//  Post.swift
//  RedditSample
//
//  Created by sdk on 7/2/19.
//  Copyright © 2019 Sdk. All rights reserved.
//

import Foundation

struct Post {
    let author: String?
    let title: String?
    let thumbnailUrl: URL?
    let numberOfComments: Int?
    
    init?(_ dictionary: [String: Any]?) {
        if let dataDic = dictionary {
            author = dataDic["author"] as? String
            title = dataDic["title"] as? String
            if let thumbnailUrlString = dataDic["thumbnail"] as? String {
                thumbnailUrl = URL(string: thumbnailUrlString)
            } else {
                thumbnailUrl = nil
            }
            numberOfComments = dataDic["num_comments"] as? Int
        } else {
            return nil
        }
        print(self)
        print("------------")
    }
}
