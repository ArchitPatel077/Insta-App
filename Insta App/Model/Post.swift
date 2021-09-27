//
//  Post.swift
//  Post
//
//  Created by Archit Patel on 2021-09-17.
//

import UIKit
import Firebase

struct Post {
    var caption : String
    var likes : Int
    let imageUrl : String
    let ownerUid : String
    let timestamp : Timestamp
    let postId: String
    let ownerImageUrl : String
    let ownerUsername: String
    var didLike = false
    
    init(postId: String, dictionary : [String : Any]) {
        self.postId = postId
        self.caption = dictionary["caption"] as? String ?? ""
        self.likes = dictionary["likes"] as? Int ?? 0
        self.imageUrl = dictionary["imageUrl"] as? String ?? ""
        self.timestamp = dictionary["timestamp"] as? Timestamp ?? Timestamp(date: Date())
        self.ownerUid = dictionary["ownerUid"] as? String ?? ""
        self.ownerImageUrl = dictionary["ownerImageUrl"] as? String ?? ""
        self.ownerUsername = dictionary["ownerUsername"] as? String ?? ""

        
    }
    
}
