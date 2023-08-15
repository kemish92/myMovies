//
//  LoginViewController.swift
//  myMovies
//
//  Created by Alberto Kemish Flores Macias on 8/10/23.
//

import CoreData
import UIKit
import WebKit

class LoginViewController: UIViewController, WKNavigationDelegate {
    var temToken = ""
    let authenticationManager = AuthenticationManager()
    
    private let continueAsGuest: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .none
        button.setTitleColor(.white, for: .normal)
        button.setTitle("\(DefaultValuesString.continueAsGuest.localized)", for: .normal)
        button.addTarget(self, action: #selector(continueGuest), for: .touchDown)
        return button
    }()
    
    private let tmdbLogo: UIImageView = {
        let imageName = "\(DefaultValuesString.defaultLogoLogin.localized)"
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
        textField.textColor = UIColor.black
        let attributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.cardsTitle
        ]
        textField.attributedPlaceholder = NSAttributedString(string: LoginStrings.usernamePlaceholder.localized, attributes: attributes)
        return textField
    }()
    
    let passwordTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = LoginStrings.passwordPlaceholder.localized
        textField.borderStyle = .roundedRect
        textField.isSecureTextEntry = true
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.textColor = UIColor.black
        let attributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.cardsTitle
        ]
        textField.attributedPlaceholder = NSAttributedString(string: LoginStrings.passwordPlaceholder.localized, attributes: attributes)
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
        label.font = UIFont(name: "\(DefaultValuesString.defaultFont.localized)", size: CustomFontSizes.parragraph)
        label.textAlignment = .center
        label.numberOfLines = 2
        return label
    }()
    
    let activityIndicatorView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        view.layer.cornerRadius = 10
        return view
    }()
    
    let activityMessage: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "\(LoginStrings.activityIndicatorMessage.localized)"
        label.font = UIFont(name: "\(DefaultValuesString.defaultFont.localized)", size: CustomFontSizes.titleLarge)
        label.textAlignment = .center
        label.textColor = UIColor.cardsTitle
        return label
    }()
    
    let activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .large)
        indicator.translatesAutoresizingMaskIntoConstraints = false
        indicator.color = .gray
        return indicator
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loginErrorMessage.isHidden = true
        activityIndicatorView.isHidden = true
        self.navigationItem.setHidesBackButton(true, animated: true)
        self.navigationController?.navigationBar.backgroundColor = .none
        setupUI()
        setColors()
        setToolbar()
        setupKeyboardHiding()
        
        GetUserTemporaryToken().getToken { token in
            if let token = token {
                let getNewToken = token
                self.temToken = getNewToken
            }
        }
        
        if let sessionId = SessionManager.shared.readSessionId() {
            SessionManager.shared.deleteSessionId()
        }
        
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
        
        view.addSubview(continueAsGuest)
        NSLayoutConstraint.activate([
            continueAsGuest.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            continueAsGuest.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            continueAsGuest.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            continueAsGuest.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
        
        view.addSubview(activityIndicatorView)
        NSLayoutConstraint.activate([
            activityIndicatorView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: view.frame.height/15),
            activityIndicatorView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -view.frame.height/15),
            activityIndicatorView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            activityIndicatorView.heightAnchor.constraint(equalToConstant: view.frame.height/4)
        ])
        
        
        activityIndicatorView.addSubview(activityMessage)
        NSLayoutConstraint.activate([
            activityMessage.leadingAnchor.constraint(equalTo: activityIndicatorView.leadingAnchor),
            activityMessage.trailingAnchor.constraint(equalTo: activityIndicatorView.trailingAnchor),
            activityMessage.topAnchor.constraint(equalTo: activityIndicatorView.topAnchor, constant: 30)
        ])
        
        
        activityIndicatorView.addSubview(activityIndicator)
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: activityIndicatorView.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: activityIndicatorView.centerYAnchor)
        ])
        activityIndicator.startAnimating()
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
        if loginAuth == "debug_disabled"{
            authenticateUser(username: username, password: password)
            requestSessionId()
        } else if loginAuth == "debug_enabled"{
            DispatchQueue.main.async {
                let vc = MoviesMainViewController()
                self.navigationController?.show(vc, sender: nil)
            }
        }
    }
    
    func setToolbar(){
        let keyboardToolbar = UIToolbar()
        keyboardToolbar.sizeToFit()
        let cancelButton = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancelButtonTapped))
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneButtonTapped))
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        keyboardToolbar.setItems([cancelButton, flexibleSpace, doneButton], animated: false)
        
        passwordTextField.inputAccessoryView = keyboardToolbar
        usernameTextField.inputAccessoryView = keyboardToolbar
    }
    
    func authenticateUser(username: String, password: String) {
        activityIndicatorView.isHidden = false
        authenticationManager.validateRequestTokenWithLogin(username: username, password: password, requestToken: temToken) { isSuccess in
            if isSuccess {
                DispatchQueue.main.async {
                    self.loginErrorMessage.isHidden = true
                    let vc = MoviesMainViewController()
                    self.navigationController?.show(vc, sender: nil)
                }
            } else {
                DispatchQueue.main.async {
                    self.activityIndicatorView.isHidden = true
                    self.loginErrorMessage.isHidden = false
                }
            }
        }
    }
    
    @objc func continueGuest(){
        let vc = MoviesMainViewController()
        self.navigationController?.show(vc, sender: nil)
    }
    
    func requestSessionId(){
        let createSessionURL = URL(string: "\(DefaultValuesString.mainUrl.localized)authentication/session/new?api_key=cb6238d228aa293e6bea5222966f8dbd")!
        var request = URLRequest(url: createSessionURL)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let body = [
            "request_token": "\(self.temToken)"
        ]
        let jsonData = try? JSONSerialization.data(withJSONObject: body)
        request.httpBody = jsonData
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Error: \(error)")
                return
            }
            
            if let data = data {
                do {
                    let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
                    if let sessionId = json?["session_id"] as? String {
                        SessionManager.shared.insertSessionId(id: sessionId)
                    }
                } catch {
                    print("Error: \(error)")
                }
            }
        }.resume()
    }
    
    @objc func cancelButtonTapped() {
        view.endEditing(true)
    }

    @objc func doneButtonTapped() {
        view.endEditing(true)
    }
}

extension UIResponder {
    private struct Static {
        static weak var responder: UIResponder?
    }
    
    static func currentFirst() -> UIResponder? {
        Static.responder = nil
        UIApplication.shared.sendAction(#selector(UIResponder._trap), to: nil, from: nil, for: nil)
        return Static.responder
    }
    
    @objc private func _trap(){
        Static.responder = self
    }
}
