//
//  StartViewController.swift
//  Clove
//
//  Created by Sivaprakash Ragavan on 8/27/17.
//  Copyright © 2017 Clove HQ. All rights reserved.
//

import UIKit

class StartViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        initViewElements()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(true, animated: false)
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
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

    lazy var titleLabel: UILabel! = {
        let view = UILabel()
        view.text = "Clove"
        view.translatesAutoresizingMaskIntoConstraints = false
        view.textAlignment = .center
        view.textColor = UIColor.white
        view.font = UIFont.boldSystemFont(ofSize: 40)
        return view
    }()

    lazy var messageLabel: UILabel! = {
        let view = UILabel()
        view.text = "Capture every voice\nin your own Audio Journal"
        view.translatesAutoresizingMaskIntoConstraints = false
        view.textAlignment = .center
        view.numberOfLines = 3
        view.font = UIFont.systemFont(ofSize: 18)
        view.textColor = UIColor.white
        return view
    }()

    lazy var signupButton: UIButton! = {
        let view = UIButton()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.addTarget(self, action: #selector(signupAction(_:)), for: .touchDown)
        view.setTitle("Get started", for: .normal)
        view.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        view.layer.cornerRadius = 5
        view.backgroundColor = UIColor.white
        view.setTitleColor(UIColor.primaryColor(), for: .normal)
        return view
    }()
    
    lazy var loginButton: UIButton! = {
        let view = UIButton()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.addTarget(self, action: #selector(loginAction(_:)), for: .touchDown)
        view.setTitle("Log in", for: .normal)
        view.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        view.layer.cornerRadius = 5
        view.backgroundColor = UIColor.primaryColor()
        view.setTitleColor(UIColor.white, for: .normal)
        return view
    }()

    func initViewElements() {
        view.addSubview(logoView)
        view.addSubview(titleLabel)
        view.addSubview(messageLabel)
        view.addSubview(signupButton)
        view.addSubview(loginButton)
        view.setNeedsUpdateConstraints()
        view.backgroundColor = UIColor.primaryColor()
    }
    
    func positionViewElements() {

        logoView.topAnchor.constraint(equalTo: topLayoutGuide.bottomAnchor, constant: 20).isActive = true
        logoView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        logoView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        logoView.widthAnchor.constraint(equalToConstant: 100).isActive = true

        titleLabel.topAnchor.constraint(equalTo: logoView.bottomAnchor).isActive = true
        titleLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor, constant: 10).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor, constant: -10).isActive = true

        messageLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 45).isActive = true
        messageLabel.heightAnchor.constraint(equalToConstant: 60).isActive = true
        messageLabel.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor, constant: 10).isActive = true
        messageLabel.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor, constant: -10).isActive = true
        
        signupButton.topAnchor.constraint(equalTo: messageLabel.bottomAnchor, constant: 15).isActive = true
        signupButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        signupButton.widthAnchor.constraint(equalToConstant: 180).isActive = true
        signupButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        loginButton.topAnchor.constraint(equalTo: signupButton.bottomAnchor, constant: 15).isActive = true
        loginButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        loginButton.widthAnchor.constraint(equalToConstant: 100).isActive = true
        loginButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }
    
    func signupAction(_ sender: AnyObject) {
        let viewController = SignupViewController()
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    
    func loginAction(_ sender: AnyObject) {
        let viewController = LoginViewController()
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    
}
