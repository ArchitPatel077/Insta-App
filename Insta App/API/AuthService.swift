//
//  AuthService.swift
//  AuthService
//
//  Created by Archit Patel on 2021-08-12.
//

import UIKit
import Firebase

struct AuthCredentials {
    let email: String
    let password: String
    let fullname: String
    let username: String
    let profieImage: UIImage
}

struct AuthService {
    
    static func registerUser(withCredential credentials : AuthCredentials, completion: @escaping(Error?) -> Void) {
        
        ImageUploader.uploadImage(image:  credentials.profieImage) { imageUrl in
            
            Auth.auth().createUser(withEmail: credentials.email, password: credentials.password) { result, error in
                
                if let error = error {
                    print("DEBUG: Fail to register user \(error.localizedDescription)")
                    return
                }
                
                guard let uid = result?.user.uid else {return}
                
                let data: [String: Any] = ["email" : credentials.email,
                                           "fullname" : credentials.fullname,
                                           "profileImageUrl" : imageUrl,
                                           "uid" : uid,
                                           "username" : credentials.username]
                
                Firestore.firestore().collection("users").document(uid).setData(data, completion: completion)
            }
        }
    }
}
