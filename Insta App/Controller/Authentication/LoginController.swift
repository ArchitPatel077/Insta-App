//
//  LoginController.swift
//  LoginController
//
//  Created by Archit Patel on 2021-08-04.
//

import UIKit


class LoginController : UIViewController {
    
     
    //MARK: - Properties
    
    private var viewModel = LoginViewModel()
    
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
    }
    
    //MARK: - Actions
    
    @objc func handleShowSignUp(){
        let controller = RegistratioinController()
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
