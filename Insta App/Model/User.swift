//
//  User.swift
//  User
//
//  Created by Archit Patel on 2021-09-13.
//

import UIKit


struct User {
    let email : String
    let fullname : String
    let profileImageUrl : String
    let username : String
    let uid : String
    
    init(dictionary : [String : Any]) {
        self.email = dictionary["email"] as? String ?? ""
        self.fullname = dictionary["fullname"] as? String ?? ""
        self.profileImageUrl = dictionary["profileImageUrl"] as? String ?? ""
        self.username = dictionary["username"] as? String ?? ""
        self.uid = dictionary["uid"] as? String ?? ""
    }
}
