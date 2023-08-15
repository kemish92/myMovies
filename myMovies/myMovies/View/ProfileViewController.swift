//
//  ProfileViewController.swift
//  myMovies
//
//  Created by Alberto Kemish Flores Macias on 8/11/23.
//

import UIKit

class ProfileViewController: UIViewController {
    private let mainView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let profileTitle: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = ProfileStrings.profileTitle.localized
        label.textColor = UIColor.cardsTitle
        label.font = UIFont(name: "\(DefaultValuesString.defaultFont.localized)", size: CustomFontSizes.titleLarge)
        return label
    }()
    
    private let userDetailsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    private let usernameView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let usernameImage: UIImageView = {
        let imageName = "profile.png"
        let image = UIImage(named: imageName)
        let imageView = UIImageView(image: image!)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let usernameTextView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let userName: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = ""
        label.textColor = UIColor.cardsTitle
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.customBlackBackground
        setUI()
    }
    
    private func setUI(){
        view.addSubview(mainView)
        NSLayoutConstraint.activate([
            mainView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            mainView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            mainView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 30),
            mainView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
        
        mainView.addSubview(profileTitle)
        NSLayoutConstraint.activate([
            profileTitle.leadingAnchor.constraint(equalTo: mainView.leadingAnchor),
            profileTitle.trailingAnchor.constraint(equalTo: mainView.trailingAnchor),
            profileTitle.topAnchor.constraint(equalTo: mainView.safeAreaLayoutGuide.topAnchor),
            profileTitle.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        mainView.addSubview(userDetailsStackView)
        NSLayoutConstraint.activate([
            userDetailsStackView.leadingAnchor.constraint(equalTo: mainView.leadingAnchor),
            userDetailsStackView.trailingAnchor.constraint(equalTo: mainView.trailingAnchor),
            userDetailsStackView.topAnchor.constraint(equalTo: profileTitle.bottomAnchor),
            userDetailsStackView.heightAnchor.constraint(equalToConstant: 150)
        ])
        
        userDetailsStackView.addArrangedSubview(usernameView)
        usernameView.addSubview(usernameImage)
        NSLayoutConstraint.activate([
            usernameImage.leadingAnchor.constraint(equalTo: usernameView.leadingAnchor),
            usernameImage.widthAnchor.constraint(equalToConstant: 150),
            usernameImage.topAnchor.constraint(equalTo: usernameView.topAnchor),
            usernameImage.bottomAnchor.constraint(equalTo: usernameView.bottomAnchor),
        ])
        
        userDetailsStackView.addArrangedSubview(usernameTextView)
        usernameTextView.addSubview(userName)
        NSLayoutConstraint.activate([
            userName.leadingAnchor.constraint(equalTo: usernameTextView.leadingAnchor),
            userName.trailingAnchor.constraint(equalTo: usernameTextView.trailingAnchor),
            userName.topAnchor.constraint(equalTo: usernameTextView.topAnchor),
            userName.bottomAnchor.constraint(equalTo: usernameTextView.bottomAnchor),
        ])
    }

}
