//
//  PostViewModel.swift
//  PostViewModel
//
//  Created by Archit Patel on 2021-09-17.
//

import UIKit

struct PostViewModel {
     var post : Post
    
    var imageUrl : URL? {
        return URL(string: post.imageUrl)
    }
    
    var caption : String {
        return post.caption
    }
    
    var likes : Int {
        return post.likes
    }
    
    var likesButtonTintColor: UIColor {
        return post.didLike ? .red : .black
    }
    
    var likeButtonImage : UIImage? {
        
//        let imageName = post.didLike ? "like_selected" : "like_unsele"
        return post.didLike ? UIImage(named: "like_selected") : UIImage(named: "like_unselected")
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
