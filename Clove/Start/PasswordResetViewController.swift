//
//  PasswordResetViewController.swift
//  Clove
//
//  Created by Sivaprakash Ragavan on 8/31/17.
//  Copyright © 2017 Clove HQ. All rights reserved.
//

import UIKit
import Parse

class PasswordResetViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initViewElements()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(false, animated: false)
        navigationItem.title = "Password Reset"
    }
    
    override func updateViewConstraints() {
        positionViewElements()
        super.updateViewConstraints()
    }
    
    lazy var messageLabel: UILabel! = {
        let view = UILabel()
        view.text = "Forgot your password?"
        view.translatesAutoresizingMaskIntoConstraints = false
        view.textAlignment = .center
        view.textColor = UIColor.gray
        view.font = UIFont.boldSystemFont(ofSize: 20)
        view.numberOfLines = 1
        return view
    }()
    
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
    
    lazy var resetButton: UIButton! = {
        let view = UIButton()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.addTarget(self, action: #selector(resetAction(_:)), for: .touchDown)
        view.setTitle("Reset it", for: .normal)
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
        view.addSubview(messageLabel)
        view.addSubview(emailField)
        view.addSubview(resetButton)
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
        
        resetButton.topAnchor.constraint(equalTo: emailField.bottomAnchor, constant: 20).isActive = true
        resetButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        resetButton.widthAnchor.constraint(equalToConstant: 100).isActive = true
        resetButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        activityIndicator.bottomAnchor.constraint(equalTo: bottomLayoutGuide.topAnchor).isActive = true
        activityIndicator.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        activityIndicator.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        activityIndicator.centerYAnchor.constraint(equalTo: topLayoutGuide.bottomAnchor, constant: 80).isActive = true
    }
    
    func resetAction(_ sender: AnyObject) {
        reset()
    }
    
    func reset() {
        if(emailField.text == "") {
            return
        }
        
        let username = emailField.text!
        
        messageLabel.text = "Sending an email with a reset link..."
        messageLabel.textColor = UIColor.gray
        messageLabel.font = UIFont.systemFont(ofSize: 14)
        messageLabel.numberOfLines = 2
        activityIndicator.startAnimating()
        
        PFUser.requestPasswordResetForEmail(inBackground: username) { succeeded, error in
            self.activityIndicator.stopAnimating()
            if succeeded {
                self.messageLabel.text = "We sent you an email.\nPlease check your inbox."
                self.messageLabel.textColor = UIColor.green
                self.messageLabel.font = UIFont.systemFont(ofSize: 14)
                self.messageLabel.numberOfLines = 2
            } else if let error: NSError = error as NSError? {
                var errorMessage: String!
                
                switch error.code {
                case 100:
                    errorMessage = "Please check your internet connection\nand try again."
                default:
                    errorMessage = "Could not reset your password.\nPlease try again after few minutes."
                }
                
                print("Error during password reset : \(errorMessage)", error)
                
                self.messageLabel.text = errorMessage
                self.messageLabel.textColor = UIColor.red
                self.messageLabel.font = UIFont.systemFont(ofSize: 14)
                self.messageLabel.numberOfLines = 2
            }
        }
    }
}

// MARK:- ---> Textfield Delegates
extension PasswordResetViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        reset()
        return true
    }
}
