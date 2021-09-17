//
//  Constants.swift
//  Constants
//
//  Created by Archit Patel on 2021-09-13.
//

import UIKit
import Firebase

let COLLECTION_USERS = Firestore.firestore().collection("users")
let COLLECTIONN_FOLLOWERS =  Firestore.firestore().collection("followers")
let COLLECTIONN_FOLLOWING =  Firestore.firestore().collection("following")
let COLLECTION_POSTS = Firestore.firestore().collection("posts")

