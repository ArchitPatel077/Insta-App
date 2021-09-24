//
//  PostViewModel.swift
//  PostViewModel
//
//  Created by Archit Patel on 2021-09-17.
//

import UIKit

struct PostViewModel {
     let post : Post
    
    var imageUrl : URL? {
        return URL(string: post.imageUrl)
    }
    
    var caption : String {
        return post.caption
    }
    
    var likes : Int {
        return post.likes
    }
    
    var likesLabelText : String {
        if post.likes != 1 {
            return "\(post.likes) likes"
        } else {
            return "\(post.likes) like"
        }
    }
    
    var userProfileImageUrl : URL? {
        return URL(string: post.ownerImageUrl)
    }
    
    var username : String {
        return post.ownerUsername
    }
    
    init(post : Post){
        self.post = post
    }
}
