//
//  LoginViewController.swift
//  myMovies
//
//  Created by Alberto Kemish Flores Macias on 8/10/23.
//

import UIKit

class LoginViewController: UIViewController {
    
    private let logoView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let tmdbLogo: UIImageView = {
        let imageName = "tmdbLogo.png"
        let image = UIImage(named: imageName)
        let imageView = UIImageView(image: image!)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private let formView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let formStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.distribution = .fillEqually
        stackView.axis = .vertical
        return stackView
    }()
    
    private let usernameView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let usernameTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.layer.cornerRadius = 5
        textField.placeholder = LoginStrings.usernamePlaceholder.localized
        let attributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.lightGray
        ]
        return textField
    }()
    
    private let passwordView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let passwordTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.layer.cornerRadius = 5
        textField.placeholder = LoginStrings.passwordPlaceholder.localized
        let attributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.lightGray
        ]
        return textField
    }()
    
    private let buttonView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let buttonLogin: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = UIColor.customButtonMain
        button.setTitle(LoginStrings.loginButton.localized, for: .normal)
        button.setTitleColor(.white, for: .normal)
        return button
    }()
    
    private let loginErrorMessageView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let loginErrorMessage: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor.customErrorMessage
        label.textAlignment = .center
        label.numberOfLines = 2
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        setColors()
        setAdittionalConfigurations()
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        DismissKeyboard.dismiss()
    }
    
    func setColors(){
        view.backgroundColor = UIColor.customDarkBlue
        usernameTextField.backgroundColor = .white
        passwordTextField.backgroundColor = .white
    }

    func setUI(){
        view.addSubview(logoView)
        NSLayoutConstraint.activate([
            logoView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            logoView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            logoView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: view.bounds.height / 5),
            logoView.heightAnchor.constraint(equalToConstant: 80)
        ])
        
        logoView.addSubview(tmdbLogo)
        NSLayoutConstraint.activate([
            tmdbLogo.centerXAnchor.constraint(equalTo: logoView.centerXAnchor),
              tmdbLogo.centerYAnchor.constraint(equalTo: logoView.centerYAnchor),
              tmdbLogo.widthAnchor.constraint(equalToConstant: 80),
              tmdbLogo.heightAnchor.constraint(equalToConstant: 80)
        ])
        
        view.addSubview(formView)
        NSLayoutConstraint.activate([
            formView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            formView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            formView.topAnchor.constraint(equalTo: logoView.bottomAnchor, constant: 50),
            formView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -view.bounds.height / 4)
        ])
        
        formView.addSubview(formStackView)
        NSLayoutConstraint.activate([
            formStackView.leadingAnchor.constraint(equalTo: formView.leadingAnchor),
            formStackView.trailingAnchor.constraint(equalTo: formView.trailingAnchor),
            formStackView.topAnchor.constraint(equalTo: formView.topAnchor),
            formStackView.bottomAnchor.constraint(equalTo: formView.bottomAnchor)
        ])
        
        formStackView.addArrangedSubview(usernameView)
        usernameView.addSubview(usernameTextField)
        NSLayoutConstraint.activate([
            usernameTextField.leadingAnchor.constraint(equalTo: usernameView.leadingAnchor),
            usernameTextField.trailingAnchor.constraint(equalTo: usernameView.trailingAnchor),
            usernameTextField.topAnchor.constraint(equalTo: usernameView.topAnchor, constant: 12),
            usernameTextField.bottomAnchor.constraint(equalTo: usernameView.bottomAnchor, constant: -12)
        ])
        
        formStackView.addArrangedSubview(passwordView)
        passwordView.addSubview(passwordTextField)
        NSLayoutConstraint.activate([
            passwordTextField.leadingAnchor.constraint(equalTo: passwordView.leadingAnchor),
            passwordTextField.trailingAnchor.constraint(equalTo: passwordView.trailingAnchor),
            passwordTextField.topAnchor.constraint(equalTo: passwordView.topAnchor, constant: 12),
            passwordTextField.bottomAnchor.constraint(equalTo: passwordView.bottomAnchor, constant: -12)
        ])
        
        formStackView.addArrangedSubview(buttonView)
        buttonView.addSubview(buttonLogin)
        NSLayoutConstraint.activate([
            buttonLogin.leadingAnchor.constraint(equalTo: buttonView.leadingAnchor),
            buttonLogin.trailingAnchor.constraint(equalTo: buttonView.trailingAnchor),
            buttonLogin.topAnchor.constraint(equalTo: buttonView.topAnchor, constant: 12),
            buttonLogin.bottomAnchor.constraint(equalTo: buttonView.bottomAnchor, constant: -12)
        ])
        
        view.addSubview(loginErrorMessageView)
        NSLayoutConstraint.activate([
            loginErrorMessageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            loginErrorMessageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            loginErrorMessageView.topAnchor.constraint(equalTo: formView.bottomAnchor, constant: 10),
            loginErrorMessageView.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        loginErrorMessageView.addSubview(loginErrorMessage)
        NSLayoutConstraint.activate([
            loginErrorMessage.leadingAnchor.constraint(equalTo: loginErrorMessageView.leadingAnchor),
            loginErrorMessage.trailingAnchor.constraint(equalTo: loginErrorMessageView.trailingAnchor),
            loginErrorMessage.topAnchor.constraint(equalTo: loginErrorMessageView.topAnchor),
            loginErrorMessage.bottomAnchor.constraint(equalTo: loginErrorMessageView.bottomAnchor)
        ])
    }
    
    func setAdittionalConfigurations(){
        let leftSpacing = LeftSpacingInputs()
        leftSpacing.setLeftViews(textField: usernameTextField)
        leftSpacing.setLeftViews(textField: passwordTextField)
        buttonLogin.addTarget(self, action: #selector(loginAuth), for: .touchDown)
    }

    @objc func loginAuth(){
        guard let username = usernameTextField.text else { return }
        guard let password = passwordTextField.text else { return }
        let loginAuth = loginUser().login(username: username, password: password)
//        if loginAuth == false {
//            //CustomAlerts().alertMessage(title: "Loggin in", message: "Wait until your'e log in", viewController: self)
//            DispatchQueue.main.async {
//
//            }
//
//        } else {
//            loginErrorMessage.text = LoginStrings.errorLoginMessage.localized
//        }
        DispatchQueue.main.async {
            let vc = MoviesMainViewController()
            self.navigationController?.show(vc, sender: nil)
        }
    }
}
