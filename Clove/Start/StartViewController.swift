//
//  StartViewController.swift
//  Clove
//
//  Created by Sivaprakash Ragavan on 8/27/17.
//  Copyright © 2017 Clove HQ. All rights reserved.
//

import UIKit
import Parse

class StartViewController: UIViewController {

    var signupMode: Bool!;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initViewElements()
    }
    
    override func updateViewConstraints() {
        positionViewElements()
        super.updateViewConstraints()
    }
    
    lazy var logoView: UIImageView! = {
        let view = UIImageView(image: UIImage(named: "logo"))
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var messageLabel: UILabel! = {
        let view = UILabel()
        view.text = ""
        view.translatesAutoresizingMaskIntoConstraints = false
        view.textAlignment = .center
        view.textColor = UIColor.primaryColor()
        view.font = UIFont.systemFont(ofSize: 14)
        return view
    }()

    var textFields: [UITextField] = []
    
    lazy var emailField: CustomTextField! = {
        let view = CustomTextField()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.placeholder = "Email"
        view.borderStyle = UITextBorderStyle.roundedRect
        view.autocorrectionType = UITextAutocorrectionType.no
        view.keyboardType = UIKeyboardType.emailAddress
        view.returnKeyType = UIReturnKeyType.next
        view.autocorrectionType = .no
        view.autocapitalizationType = .none
        view.spellCheckingType = .no
        view.delegate = self
        view.contentVerticalAlignment = UIControlContentVerticalAlignment.center
        return view
    }()
    
    lazy var passwordField: CustomTextField! = {
        let view = CustomTextField()
        view.isSecureTextEntry = true
        view.translatesAutoresizingMaskIntoConstraints = false
        view.placeholder = "Password"
        view.borderStyle = UITextBorderStyle.roundedRect
        view.autocorrectionType = UITextAutocorrectionType.no
        view.keyboardType = UIKeyboardType.default
        view.returnKeyType = UIReturnKeyType.done
        view.autocorrectionType = .no
        view.autocapitalizationType = .none
        view.spellCheckingType = .no
        view.delegate = self
        view.contentVerticalAlignment = UIControlContentVerticalAlignment.center
        return view
    }()

    
    lazy var signupButton: UIButton! = {
        let view = UIButton()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.addTarget(self, action: #selector(signupAction(_:)), for: .touchDown)
        view.setTitle("Sign up", for: .normal)
        view.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        view.layer.cornerRadius = 5
        return view
    }()
    
    lazy var loginButton: UIButton! = {
        let view = UIButton()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.addTarget(self, action: #selector(loginAction(_:)), for: .touchDown)
        view.setTitle("Log in", for: .normal)
        view.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        view.layer.cornerRadius = 5
        return view
    }()

    func initViewElements() {
        navigationController?.setNavigationBarHidden(true, animated: false)
        textFields.append(emailField)
        textFields.append(passwordField)
        view.addSubview(logoView)
        view.addSubview(messageLabel)
        view.addSubview(emailField)
        view.addSubview(passwordField)
        view.addSubview(signupButton)
        view.addSubview(loginButton)
        setupSignupMode(signupMode: true)
        view.setNeedsUpdateConstraints()
    }
    
    func setupSignupMode(signupMode: Bool) {
        self.signupMode = signupMode;
        if(signupMode) {
            signupButton.backgroundColor = UIColor.primaryColor()
            signupButton.setTitleColor(UIColor.white, for: .normal)
            loginButton.backgroundColor = UIColor.white
            loginButton.setTitleColor(UIColor.primaryColor(), for: .normal)
        } else {
            loginButton.backgroundColor = UIColor.primaryColor()
            loginButton.setTitleColor(UIColor.white, for: .normal)
            signupButton.backgroundColor = UIColor.white
            signupButton.setTitleColor(UIColor.primaryColor(), for: .normal)
        }
    }
    
    func positionViewElements() {

        logoView.topAnchor.constraint(equalTo: topLayoutGuide.bottomAnchor, constant: 30).isActive = true
        logoView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        logoView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        logoView.widthAnchor.constraint(equalToConstant: 100).isActive = true

        messageLabel.topAnchor.constraint(equalTo: logoView.bottomAnchor, constant: 30).isActive = true
        messageLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        messageLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
        messageLabel.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor, constant: 10).isActive = true
        messageLabel.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor, constant: -10).isActive = true
        
        emailField.topAnchor.constraint(equalTo: messageLabel.bottomAnchor, constant: 10).isActive = true
        emailField.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor, constant: 20).isActive = true
        emailField.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor, constant: -20).isActive = true
        emailField.heightAnchor.constraint(equalToConstant: 40).isActive = true

        passwordField.topAnchor.constraint(equalTo: emailField.bottomAnchor, constant: 20).isActive = true
        passwordField.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor, constant: 20).isActive = true
        passwordField.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor, constant: -20).isActive = true
        passwordField.heightAnchor.constraint(equalToConstant: 40).isActive = true

        signupButton.topAnchor.constraint(equalTo: passwordField.bottomAnchor, constant: 20).isActive = true
        signupButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        signupButton.widthAnchor.constraint(equalToConstant: 100).isActive = true
        signupButton.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: -50).isActive = true
        
        loginButton.topAnchor.constraint(equalTo: passwordField.bottomAnchor, constant: 20).isActive = true
        loginButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        loginButton.widthAnchor.constraint(equalToConstant: 100).isActive = true
        loginButton.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 50).isActive = true
    }
    
    func signupAction(_ sender: AnyObject) {
        signUp()
    }
    
    func loginAction(_ sender: AnyObject) {
        logIn()
    }
    
    func signUp() {
        if(!signupMode) {
            setupSignupMode(signupMode: true)
            return
        }

        if(emailField.text == "" || passwordField.text == "" ) {
            return
        }
        
        messageLabel.text = "Creating your account..."
        signupButton.isUserInteractionEnabled = false
        loginButton.isUserInteractionEnabled = false

        let user = PFUser()
        user.username = emailField.text
        user.password = passwordField.text
        user.signUpInBackground { succeeded, error in
            if (succeeded) {
                let viewController = HomeViewController()
                self.navigationController?.setViewControllers([viewController], animated: true)
            } else if let error = error {
                print("Error during signup", error)
                self.messageLabel.text = "Could not create your account."
                self.signupButton.isUserInteractionEnabled = true
                self.loginButton.isUserInteractionEnabled = true
            }
        }
    }
    
    func logIn() {
        if(signupMode) {
            setupSignupMode(signupMode: false)
            return
        }
        
        if(emailField.text == "" || passwordField.text == "" ) {
            return
        }
        
        let username = emailField.text!
        let password = passwordField.text!
        
        messageLabel.text = "Logging in..."
        signupButton.isUserInteractionEnabled = false
        loginButton.isUserInteractionEnabled = false
        
        PFUser.logInWithUsername(inBackground: username, password: password) { user, error in
            if user != nil {
                let viewController = HomeViewController()
                self.navigationController?.setViewControllers([viewController], animated: true)
            } else if let error = error {
                print("Error during login", error)
                self.messageLabel.text = "Could not login"
                self.signupButton.isUserInteractionEnabled = true
                self.loginButton.isUserInteractionEnabled = true
            }
        }
    }

}

// MARK:- ---> Textfield Delegates
extension StartViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        guard let i = textFields.index(of: textField) else { return false }
        if i + 1 < textFields.count {
            textFields[i + 1].becomeFirstResponder()
            return true
        }
        textField.resignFirstResponder()
        
        if(signupMode) {
            signUp()
        } else {
            logIn()
        }
        
        return true
    }
}
