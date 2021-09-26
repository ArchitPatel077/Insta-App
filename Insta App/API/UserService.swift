//
//  UserService.swift
//  UserService
//
//  Created by Archit Patel on 2021-09-13.
//

import UIKit
import Firebase

typealias FirestoreCompletion = (Error?) -> Void

struct UserService {
    
    static func fetchUser(withUid uid: String, completion : @escaping(User) -> Void ) {
        
//        guard let uid = Auth.auth().currentUser?.uid else {return}
        COLLECTION_USERS.document(uid).getDocument { snapshot, error in
            
            guard let dictionary = snapshot?.data() else {return}
            
            let user = User(dictionary: dictionary)
            completion(user)
            
        }
    }
    
    static func fetchUsers(completion : @escaping([User]) -> Void) {
        
        COLLECTION_USERS.getDocuments { snapshot, error in
            
            guard let snapshot = snapshot else {return}
            
            let users = snapshot.documents.map({User(dictionary: $0.data())})
            completion(users)
        }
        
    }
    
    static func follow(uid: String, completion: @escaping(FirestoreCompletion) ) {
        
        guard let currrentUid = Auth.auth().currentUser?.uid else {return }
        COLLECTIONN_FOLLOWING.document(currrentUid).collection("user-following").document(uid).setData([:]) { error in
            
            COLLECTIONN_FOLLOWERS.document(uid).collection("user-followers").document(currrentUid).setData([:], completion: completion)
        }
        
    }
    
    
    
    static func unfollow(uid: String, completion: @escaping(FirestoreCompletion)) {
        
        guard let currrentUid = Auth.auth().currentUser?.uid else {return }
        
        COLLECTIONN_FOLLOWING.document(currrentUid).collection("user-following").document(uid).delete { error in
            
            COLLECTIONN_FOLLOWERS.document(uid).collection("user-followers").document(currrentUid).delete(completion: completion)
        }
    }
    
    static func checkIfUserIsFollowed(uid: String, completion: @escaping(Bool) -> Void) {
        
        guard let currrentUid = Auth.auth().currentUser?.uid else {return }
        
        COLLECTIONN_FOLLOWING.document(currrentUid).collection("user-following").document(uid).getDocument { (snapshot, error) in
            
            guard let isFollowed = snapshot?.exists else {return}
            
            completion(isFollowed)
        }
        
    }
    
    static func fetchUserStats(uid: String, completion: @escaping(UserStats) -> Void) {
        COLLECTIONN_FOLLOWERS.document(uid).collection("user-followers").getDocuments { snapshot, _ in
            
            let followers = snapshot?.documents.count ?? 0
            
            COLLECTIONN_FOLLOWING.document(uid).collection("user-following").getDocuments { snapshot, _ in
                
                let following = snapshot?.documents.count ?? 0
                
                COLLECTION_POSTS.whereField("ownerUid", isEqualTo: uid).getDocuments { snapshot, error in
                    
                    let posts = snapshot?.documents.count ?? 0
                    completion(UserStats(followers: followers, following: following, posts: posts))
                }
                
            }
        }
    }
    
}
