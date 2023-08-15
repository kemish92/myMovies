//
//  ProfileViewController.swift
//  myMovies
//
//  Created by Alberto Kemish Flores Macias on 8/11/23.
//

import UIKit

class ProfileViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    private var carouselCollectionView: UICollectionView!
    private var viewModel: ProfileViewModel!
    
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
        let imageName = "\(DefaultValuesString.defaultProfile.localized)"
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
        label.textColor = UIColor.cardsTitle
        return label
    }()
    
    private let carouselView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.customBlackBackground
        setupViewModel()
        setUI()
        guard let userName = SessionManager.shared.readUsernameId() else { return }
    }
    
    private func setupViewModel() {
        viewModel = ProfileViewModel()
        viewModel.dataUpdated = { [weak self] in
            self?.carouselCollectionView.reloadData()
        }
        
        guard let userName = SessionManager.shared.readUsernameId() else { return }
        self.userName.text = userName
        viewModel.fetchProfileData(username: userName)
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
        
        view.addSubview(carouselView)
        NSLayoutConstraint.activate([
            carouselView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            carouselView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            carouselView.topAnchor.constraint(equalTo: userDetailsStackView.bottomAnchor),
            carouselView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
        
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0

        carouselCollectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        carouselCollectionView.translatesAutoresizingMaskIntoConstraints = false
        carouselCollectionView.backgroundColor = .clear
        carouselCollectionView.dataSource = self
        carouselCollectionView.delegate = self
        
        carouselCollectionView.register(CustomCell.self, forCellWithReuseIdentifier: "cell")
        
        carouselView.addSubview(carouselCollectionView)
        NSLayoutConstraint.activate([
            carouselCollectionView.leadingAnchor.constraint(equalTo: carouselView.leadingAnchor),
            carouselCollectionView.trailingAnchor.constraint(equalTo: carouselView.trailingAnchor),
            carouselCollectionView.topAnchor.constraint(equalTo: carouselView.topAnchor),
            carouselCollectionView.bottomAnchor.constraint(equalTo: carouselView.bottomAnchor),
        ])
        
        carouselCollectionView.reloadData()
    }
}

extension ProfileViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.getNumberOfCarouselItems()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width/2 - 20, height: 350)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CustomCell
        
        if let movie = viewModel.carouselMovies?.results?[indexPath.row] {
            if let url = URL(string: "\(DefaultValuesString.urlImages.localized)\(movie.posterPath ?? "")") {
                ImageLoader.loadImage(from: url.absoluteString) { loadedImage in
                    DispatchQueue.main.async {
                        if let loadedImage = loadedImage {
                            cell.movieImage.image = loadedImage
                        } else {
                            print("\(ErrorStrings.loadingImageError.localized)")
                        }
                    }
                }
            } else {
                print("Error")
            }
            
            cell.movieTitle.text = movie.originalTitle
            let formattedDateStr = DateFormatterHelper.convertDate(movie.releaseDate ?? "")
            cell.date.text = formattedDateStr
            cell.score.text = "★ \(movie.voteAverage ?? 0.0)"
            cell.descriptionText.text = movie.overview ?? ""
        }
        
        return cell
    }

}
