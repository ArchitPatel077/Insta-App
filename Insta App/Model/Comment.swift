//
//  Comments.swift
//  Comments
//
//  Created by Archit Patel on 2021-09-24.
//

import UIKit
import Firebase

struct Comment{
    let uid : String
    let username : String
    let profileImageUrl : String
    let timeStamp : Timestamp
    let commentText : String
    
    init(dictionary: [String: Any]) {
        self.uid = dictionary["uid"] as? String ?? ""
        self.username = dictionary["username"] as? String ?? ""
        self.profileImageUrl = dictionary["profileImageUrl"] as? String ?? ""
        self.commentText = dictionary["commentText"] as? String ?? ""
        self.timeStamp = dictionary["timestamp"] as? Timestamp ?? Timestamp(date: Date())
    }
    
    
}
