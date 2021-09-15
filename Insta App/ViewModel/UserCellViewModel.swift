//
//  UserCellViewModel.swift
//  UserCellViewModel
//
//  Created by Archit Patel on 2021-09-15.
//

import UIKit

struct UserCellViewModel {
    
    private let user: User
    
    var profileImageUrl : URL? {
        return URL(string: user.profileImageUrl)
    }
    
    var username : String {
        return user.username
    }
    
    var fullname : String {
        return user.fullname
    }
    
    init(user: User) {
        self.user = user
    }
    
}
