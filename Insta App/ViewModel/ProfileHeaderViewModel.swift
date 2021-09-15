//
//  ProfileHeaderViewModel.swift
//  ProfileHeaderViewModel
//
//  Created by Archit Patel on 2021-09-13.
//

import UIKit

struct ProfileHeaderViewModel {
    let user : User
    
    var fullname : String {
        return user.fullname
    }
    
    var profileImageUrl : URL? {
        return URL(string: user.profileImageUrl)
    }
    
    init(user : User) {
        self.user = user
    }
}
