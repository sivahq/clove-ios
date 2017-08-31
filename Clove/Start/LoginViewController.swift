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
        navigationItem.title = "Welcome back!"
    }
    
    override func updateViewConstraints() {
        positionViewElements()
        super.updateViewConstraints()
    }
    
    lazy var messageLabel: UILabel! = {
        let view = UILabel()
        view.text = ""
        view.translatesAutoresizingMaskIntoConstraints = false
        view.textAlignment = .center
        view.textColor = UIColor.red
        view.font = UIFont.systemFont(ofSize: 14)
        view.numberOfLines = 2
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
    
    lazy var activityIndicator: UIActivityIndicatorView! = {
        let view = UIActivityIndicatorView.init(activityIndicatorStyle: UIActivityIndicatorViewStyle.whiteLarge)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.alpha = 0.3
        view.hidesWhenStopped = true
        view.backgroundColor = UIColor.gray
        return view
    }()
    
    func initViewElements() {
        textFields.append(emailField)
        textFields.append(passwordField)
        view.addSubview(messageLabel)
        view.addSubview(emailField)
        view.addSubview(passwordField)
        view.addSubview(loginButton)
        view.setNeedsUpdateConstraints()
        view.addSubview(activityIndicator)
        view.backgroundColor = UIColor.white
    }
    
    func positionViewElements() {
        
        messageLabel.topAnchor.constraint(equalTo: topLayoutGuide.bottomAnchor, constant: 10).isActive = true
        messageLabel.heightAnchor.constraint(equalToConstant: 40).isActive = true
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
        
        loginButton.topAnchor.constraint(equalTo: passwordField.bottomAnchor, constant: 20).isActive = true
        loginButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        loginButton.widthAnchor.constraint(equalToConstant: 100).isActive = true
        loginButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        activityIndicator.topAnchor.constraint(equalTo: topLayoutGuide.bottomAnchor).isActive = true
        activityIndicator.bottomAnchor.constraint(equalTo: bottomLayoutGuide.topAnchor).isActive = true
        activityIndicator.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        activityIndicator.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        activityIndicator.centerYAnchor.constraint(equalTo: topLayoutGuide.bottomAnchor, constant: 90).isActive = true
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
        
        messageLabel.text = ""
        activityIndicator.startAnimating()
        
        PFUser.logInWithUsername(inBackground: username, password: password) { user, error in
            self.activityIndicator.stopAnimating()
            if user != nil {
                let viewController = HomeViewController()
                self.navigationController?.setViewControllers([viewController], animated: true)
            } else if let error: NSError = error as NSError? {
                
                var errorMessage: String!
                
                switch error.code {
                case 101:
                    errorMessage = "Incorrect email and/or password."
                case 100:
                    errorMessage = "Please check your internet connection\nand try again."
                default:
                    errorMessage = "Could not login.\nPlease try again after few minutes."
                }
                
                print("Error during login : \(errorMessage)", error)
                self.messageLabel.text = errorMessage
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
