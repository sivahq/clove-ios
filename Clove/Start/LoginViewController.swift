//
//  LoginViewController.swift
//  Clove
//
//  Created by Sivaprakash Ragavan on 8/30/17.
//  Copyright © 2017 Clove HQ. All rights reserved.
//

import UIKit
import Parse

class LoginViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initViewElements()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    override func updateViewConstraints() {
        positionViewElements()
        super.updateViewConstraints()
    }
    
    lazy var messageLabel: UILabel! = {
        let view = UILabel()
        view.text = "Welcome back!"
        view.translatesAutoresizingMaskIntoConstraints = false
        view.textAlignment = .center
        view.textColor = UIColor.secondaryColor()
        view.font = UIFont.boldSystemFont(ofSize: 20)
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
    
    lazy var loginButton: UIButton! = {
        let view = UIButton()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.addTarget(self, action: #selector(loginAction(_:)), for: .touchDown)
        view.setTitle("Log in", for: .normal)
        view.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        view.layer.cornerRadius = 5
        view.backgroundColor = UIColor.primaryColor()
        view.setTitleColor(UIColor.white, for: .normal)
        return view
    }()
    
    func initViewElements() {
        view.backgroundColor = UIColor.white
        navigationItem.title = "Clove"
        textFields.append(emailField)
        textFields.append(passwordField)
        view.addSubview(messageLabel)
        view.addSubview(emailField)
        view.addSubview(passwordField)
        view.addSubview(loginButton)
        view.setNeedsUpdateConstraints()
    }
    
    func positionViewElements() {
        
        messageLabel.topAnchor.constraint(equalTo: topLayoutGuide.bottomAnchor, constant: 20).isActive = true
        messageLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
        messageLabel.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor, constant: 10).isActive = true
        messageLabel.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor, constant: -10).isActive = true
        
        emailField.topAnchor.constraint(equalTo: messageLabel.bottomAnchor, constant: 20).isActive = true
        emailField.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor, constant: 20).isActive = true
        emailField.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor, constant: -20).isActive = true
        emailField.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        passwordField.topAnchor.constraint(equalTo: emailField.bottomAnchor, constant: 20).isActive = true
        passwordField.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor, constant: 20).isActive = true
        passwordField.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor, constant: -20).isActive = true
        passwordField.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        loginButton.topAnchor.constraint(equalTo: passwordField.bottomAnchor, constant: 20).isActive = true
        loginButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        loginButton.widthAnchor.constraint(equalToConstant: 100).isActive = true
        loginButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }
    
    func loginAction(_ sender: AnyObject) {
        logIn()
    }
    
    func logIn() {
        if(emailField.text == "" || passwordField.text == "" ) {
            return
        }
        
        let username = emailField.text!
        let password = passwordField.text!
        
        messageLabel.text = "Logging in..."
        loginButton.isUserInteractionEnabled = false
        
        PFUser.logInWithUsername(inBackground: username, password: password) { user, error in
            if user != nil {
                let viewController = HomeViewController()
                self.navigationController?.setViewControllers([viewController], animated: true)
            } else if let error = error {
                print("Error during login", error)
                self.messageLabel.text = "Could not login"
                self.loginButton.isUserInteractionEnabled = true
            }
        }
    }
    
}

// MARK:- ---> Textfield Delegates
extension LoginViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        guard let i = textFields.index(of: textField) else { return false }
        if i + 1 < textFields.count {
            textFields[i + 1].becomeFirstResponder()
            return true
        }
        textField.resignFirstResponder()
        logIn()
        
        return true
    }
}
