//
//  LoginController.swift
//  LoginController
//
//  Created by Archit Patel on 2021-08-04.
//

import UIKit

protocol AuthenticationDelegate : AnyObject {
    func authenticationDidComplete()
}


class LoginController : UIViewController {
    
     
    //MARK: - Properties
    
    private var viewModel = LoginViewModel()
    weak var delegate : AuthenticationDelegate?
    
    private let iconImage : UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "Instagram_logo_white")
        iv.contentMode = .scaleAspectFill
        return iv
    }()
    
    private let emailTextField : UITextField = {
        let tf = CustomeTextField(placeHolder: "Email")
      
        tf.keyboardType = .emailAddress
       
        return tf
    }()
    
    private let passwordTextField : UITextField = {
        let tf = CustomeTextField(placeHolder: "Password")
        tf.isSecureTextEntry = true
        return tf
    }()
    
    private let loginButton : UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Log In", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .systemPurple
        button.layer.cornerRadius = 5
        button.setHeight(50)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        button.isEnabled = false
        button.addTarget(self, action: #selector(handleLogin), for: .touchUpInside)
        return button
    }()
    
    private let forgetPasswordButton : UIButton = {
        
        let button = UIButton(type: .system)
        
        button.attributeTitle(firstPart: "Forgot your password?", secondPart: "Get help signing in.")
        
        return button
        
    }()
    
    private let dontHaveAccountButton : UIButton = {
        let button = UIButton(type: .system)
        
        button.attributeTitle(firstPart: "Don't have an account? ", secondPart: "Sign Up")
        button.addTarget(self, action: #selector(handleShowSignUp), for: .touchUpInside)
        
        return button
        
    }()
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
       configureUI()
       configureNotificationObservers()
        self.emailTextField.delegate = self
        self.passwordTextField.delegate = self
    }
    
    //MARK: - Actions
    
    @objc func handleShowSignUp(){
        let controller = RegistratioinController()
        controller.delegate = delegate
        navigationController?.pushViewController(controller, animated: true)
    }
    
    @objc func textDidChange(sender: UITextField){
        if sender == emailTextField{
            viewModel.email = sender.text
        } else {
            viewModel.password = sender.text
        }
        
        updateForm()
    }
    
    @objc func handleLogin() {
        
        guard let email = emailTextField.text else {return}
        guard let password = passwordTextField.text else {return}
        
        AuthService.logUserIn(withEmail: email, password: password) { result, error in
            
            if let error = error {
                print("DEBUG: Fail to log user in\(error.localizedDescription)")
                return
            }
            
            self.delegate?.authenticationDidComplete()
            
        }
        
    }
    
    //MARK: - Helpers
    
    func configureUI() {
        connfigureGradientlayer()
        navigationController?.navigationBar.isHidden = true
        navigationController?.navigationBar.barStyle = .black
        
        view.addSubview(iconImage)
        iconImage.centerX(inView: view)
        iconImage.setDimensions(height: 80, width: 120)
        iconImage.anchor(top: view.safeAreaLayoutGuide.topAnchor, paddingTop: 32)
        
        let stack = UIStackView(arrangedSubviews: [emailTextField, passwordTextField, loginButton, forgetPasswordButton])
        stack.axis = .vertical
        stack.spacing = 20
        
        
        view.addSubview(stack)
        stack.anchor(top: iconImage.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 32, paddingLeft: 32, paddingRight: 32)
        
        view.addSubview(dontHaveAccountButton)
        dontHaveAccountButton.centerX(inView: view)
        dontHaveAccountButton.anchor(bottom: view.safeAreaLayoutGuide.bottomAnchor)
        
    }
    
    func configureNotificationObservers() {
        emailTextField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
        passwordTextField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
    }
}

//MARK: - FormViewModel

extension LoginController : FormViewModel {
    
    func updateForm() {
        loginButton.backgroundColor = viewModel.buttonBackgroundColor
        loginButton.setTitleColor(viewModel.buttonTitleColor, for: .normal)
        loginButton.isEnabled = viewModel.formIsValid
    }
}


extension LoginController : UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        textField.resignFirstResponder()
        return true
    }
}
