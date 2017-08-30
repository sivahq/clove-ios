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
    }
    
    override func updateViewConstraints() {
        positionViewElements()
        super.updateViewConstraints()
    }
    
    lazy var messageLabel: UILabel! = {
        let view = UILabel()
        view.text = "Create your account"
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
    
    func initViewElements() {
        view.backgroundColor = UIColor.white
        navigationItem.title = "Clove"
        textFields.append(emailField)
        textFields.append(passwordField)
        view.addSubview(messageLabel)
        view.addSubview(emailField)
        view.addSubview(passwordField)
        view.addSubview(signupButton)
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
        
        signupButton.topAnchor.constraint(equalTo: passwordField.bottomAnchor, constant: 20).isActive = true
        signupButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        signupButton.widthAnchor.constraint(equalToConstant: 100).isActive = true
        signupButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }
    
    func signupAction(_ sender: AnyObject) {
        signUp()
    }
    
    func signUp() {
        if(emailField.text == "" || passwordField.text == "" ) {
            return
        }
        
        messageLabel.text = "Creating your account..."
        signupButton.isUserInteractionEnabled = false
        
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
