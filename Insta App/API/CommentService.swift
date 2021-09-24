//
//  CommentService.swift
//  CommentService
//
//  Created by Archit Patel on 2021-09-24.
//

import UIKit
import Firebase

struct CommentService {
    
    static func uploadComment(comment : String, postId : String, user : User, completion : @escaping(FirestoreCompletion)) {
        
        let data : [String : Any] = ["uid" : user.uid,
                                     "comment" : comment,
                                     "timestamp" : Timestamp(date: Date()),
                                     "username" : user.username,
                                     "profileImageUrl" : user.profileImageUrl]
        
        COLLECTION_POSTS.document(postId).collection("comments").addDocument(data: data, completion: completion)
    }
    
    static func fetchComment(forPost postID: String, completion: @escaping([Comment]) -> Void) {
        
        var comments = [Comment]()
        
        let query = COLLECTION_POSTS.document(postID).collection("comments").order(by: "timestamp", descending: true)
        
        query.addSnapshotListener { snapshot, error in
            snapshot?.documentChanges.forEach({ change in
                if change.type == .added {
                    let data = change.document.data()
                    let comment = Comment(dictionary: data)
                    comments.append(comment)
                }
            })
            
            completion(comments)
        }
        
    }
}
