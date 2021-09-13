//
//  AuthenticationViewModel.swift
//  AuthenticationViewModel
//
//  Created by Archit Patel on 2021-08-05.
//

import UIKit

protocol FormViewModel{
    func updateForm()
}
protocol AuthenticationViewModel {
    var formIsValid : Bool {get}
    var buttonBackgroundColor: UIColor {get}
    var buttonTitleColor: UIColor {get}
}

struct LoginViewModel : AuthenticationViewModel {
    var email : String?
    var password : String?
    
    var formIsValid: Bool {
        return email?.isEmpty == false && password?.isEmpty == false
    }
    
    var buttonBackgroundColor: UIColor {
        return formIsValid ? UIColor.blue: UIColor.purple.withAlphaComponent(0.5)
    }
    
    var buttonTitleColor: UIColor {
        return formIsValid ? .white : UIColor(white: 1, alpha: 0.67)
    }
}

struct RegistrationViewModel : AuthenticationViewModel {

    var email : String?
    var password : String?
    var fullname : String?
    var username : String?
    
    var formIsValid: Bool{
        return email?.isEmpty == false && password?.isEmpty == false && fullname?.isEmpty == false && username?.isEmpty == false
    }
    
    var buttonBackgroundColor: UIColor{
        return formIsValid ? UIColor.blue: UIColor.purple.withAlphaComponent(0.5)
    }
    
    var buttonTitleColor: UIColor{
        return formIsValid ? .white : UIColor(white: 1, alpha: 0.67)
    }
}