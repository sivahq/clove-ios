//
//  SignupViewController.swift
//  Clove
//
//  Created by Sivaprakash Ragavan on 8/30/17.
//  Copyright © 2017 Clove HQ. All rights reserved.
//

import UIKit
import Parse

class SignupViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initViewElements()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(false, animated: false)
        navigationItem.title = "Get Started"
    }
    
    override func updateViewConstraints() {
        positionViewElements()
        super.updateViewConstraints()
    }
    
    lazy var messageLabel: UILabel! = {
        let view = UILabel()
        view.text = "Let's create your account"
        view.translatesAutoresizingMaskIntoConstraints = false
        view.textAlignment = .center
        view.textColor = UIColor.gray
        view.font = UIFont.boldSystemFont(ofSize: 20)
        view.numberOfLines = 1
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
    
    lazy var passwordConfirmField: CustomTextField! = {
        let view = CustomTextField()
        view.isSecureTextEntry = true
        view.translatesAutoresizingMaskIntoConstraints = false
        view.placeholder = "Confirm Password"
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
        textFields.append(passwordConfirmField)
        view.addSubview(messageLabel)
        view.addSubview(emailField)
        view.addSubview(passwordField)
        view.addSubview(passwordConfirmField)
        view.addSubview(signupButton)
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

        passwordConfirmField.topAnchor.constraint(equalTo: passwordField.bottomAnchor, constant: 20).isActive = true
        passwordConfirmField.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor, constant: 20).isActive = true
        passwordConfirmField.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor, constant: -20).isActive = true
        passwordConfirmField.heightAnchor.constraint(equalToConstant: 40).isActive = true

        signupButton.topAnchor.constraint(equalTo: passwordConfirmField.bottomAnchor, constant: 20).isActive = true
        signupButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        signupButton.widthAnchor.constraint(equalToConstant: 100).isActive = true
        signupButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        activityIndicator.bottomAnchor.constraint(equalTo: bottomLayoutGuide.topAnchor).isActive = true
        activityIndicator.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        activityIndicator.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        activityIndicator.centerYAnchor.constraint(equalTo: topLayoutGuide.bottomAnchor, constant: 110).isActive = true
    }
    
    func signupAction(_ sender: AnyObject) {
        signUp()
    }
    
    func signUp() {
        if(emailField.text == "" || passwordField.text == "" || passwordConfirmField.text == "" ) {
            return
        }
        
        if(passwordField.text != passwordConfirmField.text) {
            messageLabel.text = "Passwords don't match."
            messageLabel.textColor = UIColor.red
            messageLabel.font = UIFont.systemFont(ofSize: 14)
            messageLabel.numberOfLines = 2
            return
        }
        
        messageLabel.text = "Creating your account..."
        messageLabel.textColor = UIColor.gray
        messageLabel.font = UIFont.systemFont(ofSize: 14)
        messageLabel.numberOfLines = 2
        activityIndicator.startAnimating()
        
        let user = PFUser()
        user.username = emailField.text
        user.email = emailField.text
        user.password = passwordField.text
        user.signUpInBackground { succeeded, error in
            self.activityIndicator.stopAnimating()
            if (succeeded) {
                let viewController = HomeViewController()
                self.navigationController?.setViewControllers([viewController], animated: true)
            } else if let error: NSError = error as NSError? {

                var errorMessage: String!
                
                switch error.code {
                case PFErrorCode.errorUsernameTaken.rawValue:
                    errorMessage = "Email already in use."
                case 100:
                    errorMessage = "Please check your internet connection\nand try again."
                default:
                    errorMessage = "Could not create your account.\nPlease try again after few minutes."
                }

                print("Error during signup : \(errorMessage)", error)
                
                self.messageLabel.text = errorMessage
                self.messageLabel.textColor = UIColor.red
                self.messageLabel.font = UIFont.systemFont(ofSize: 14)
                self.messageLabel.numberOfLines = 2
            }
        }

    }
    
}

// MARK:- ---> Textfield Delegates
extension SignupViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        guard let i = textFields.index(of: textField) else { return false }
        if i + 1 < textFields.count {
            textFields[i + 1].becomeFirstResponder()
            return true
        }
        textField.resignFirstResponder()
        signUp()
        
        return true
    }
}
