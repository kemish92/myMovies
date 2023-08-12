//
//  LoginViewController.swift
//  myMovies
//
//  Created by Alberto Kemish Flores Macias on 8/10/23.
//

import UIKit

class LoginViewController: UIViewController {
    private let tmdbLogo: UIImageView = {
        let imageName = "tmdbLogo.png"
        let image = UIImage(named: imageName)
        let imageView = UIImageView(image: image!)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let usernameTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = LoginStrings.usernamePlaceholder.localized
        textField.borderStyle = .roundedRect
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    let passwordTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = LoginStrings.passwordPlaceholder.localized
        textField.borderStyle = .roundedRect
        textField.isSecureTextEntry = true
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    let loginButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = UIColor.customButtonMain
        button.setTitle(LoginStrings.loginButton.localized, for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.addTarget(self, action: #selector(loginAuth), for: .touchDown)
        return button
    }()
    
    private let loginErrorMessage: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor.customErrorMessage
        label.text = LoginStrings.errorLoginMessage.localized
        label.font = UIFont(name: "AppleSDGothicNeo-Bold", size: CustomFontSizes.parragraph)
        label.textAlignment = .center
        label.numberOfLines = 2
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setColors()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        DismissKeyboard.dismiss()
    }
    
    func setupUI() {
        view.backgroundColor = UIColor.customDarkBlue
        
        view.addSubview(usernameTextField)
        NSLayoutConstraint.activate([
            usernameTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            usernameTextField.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            usernameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            usernameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            usernameTextField.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        view.addSubview(tmdbLogo)
        NSLayoutConstraint.activate([
            tmdbLogo.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            tmdbLogo.bottomAnchor.constraint(equalTo: usernameTextField.topAnchor, constant: -20),
            tmdbLogo.widthAnchor.constraint(equalToConstant: 120),
            tmdbLogo.heightAnchor.constraint(equalToConstant: 120)
        ])
        
        view.addSubview(passwordTextField)
        NSLayoutConstraint.activate([
            passwordTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            passwordTextField.topAnchor.constraint(equalTo: usernameTextField.bottomAnchor, constant: 20),
            passwordTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            passwordTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            passwordTextField.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        view.addSubview(loginButton)
        NSLayoutConstraint.activate([
            loginButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            loginButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            loginButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 20),
            loginButton.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        view.addSubview(loginErrorMessage)
        NSLayoutConstraint.activate([
            loginErrorMessage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loginErrorMessage.topAnchor.constraint(equalTo: loginButton.bottomAnchor, constant: 5),
            loginErrorMessage.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            loginErrorMessage.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
    }
    
    func setColors(){
        view.backgroundColor = UIColor.customDarkBlue
        usernameTextField.backgroundColor = .white
        passwordTextField.backgroundColor = .white
    }
    
    @objc func loginAuth(){
        guard let username = usernameTextField.text else { return }
        guard let password = passwordTextField.text else { return }
        let loginAuth = loginUserValidator().loginValidator()
        print(loginAuth)
        if loginAuth == "debug_disabled"{//Off
            //CustomAlerts().alertMessage(title: "Loggin in", message: "Wait until your'e log in", viewController: self)
            var loginResponse = loginUser().login(username: username, password: password)
        } else if loginAuth == "debug_enabled"{
            DispatchQueue.main.async {
                let vc = MoviesMainViewController()
                self.navigationController?.show(vc, sender: nil)
            }
        }
    }
}




