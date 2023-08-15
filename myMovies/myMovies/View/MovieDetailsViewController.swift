//
//  MovieDetailsViewController.swift
//  myMovies
//
//  Created by Alberto Kemish Flores Macias on 8/11/23.
//

import UIKit

class MovieDetailsViewController: UIViewController {
    var detailsViewModel = MovieDetailsViewModel()
    var selectedMovieId = 0
    var showType = ""
    private let mainImageContainer: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .none
        return view
    }()
    
    private let mainDescriptionContainer: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.customDarkBlue
        return view
    }()
    
    let movieImage: UIImageView = {
        let imageName = "\(DefaultValuesString.defaultImage.localized)"
        let image = UIImage(named: imageName)
        let imageView = UIImageView(image: image!)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 20
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let movieTitle: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 2
        label.font = UIFont(name: "\(DefaultValuesString.defaultFont.localized)", size: CustomFontSizes.titleLarge)
        label.textColor = .white
        return label
    }()
    
    private let voteAverageView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let gradientImg: UIImageView = {
        let imageName = "\(DefaultValuesString.defaultImageGradient.localized)"
        let image = UIImage(named: imageName)
        let imageView = UIImageView(image: image!)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let gradientFavoriteView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let gradientFavorite: UIImageView = {
        let imageName = "\(DefaultValuesString.defaultImageGradient.localized)"
        let image = UIImage(named: imageName)
        let imageView = UIImageView(image: image!)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let voteAverage: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "★"
        label.textAlignment = .right
        label.font = UIFont(name: "\(DefaultValuesString.defaultFont.localized)", size: CustomFontSizes.titleLarge)
        label.textColor = .white
        return label
    }()
    
    private let movieStats: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.distribution = .fillProportionally
        stackView.axis = .horizontal
        return stackView
    }()
    
    private let releaseDate: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textColor = UIColor.cardsTitle
        return label
    }()
    
    private let runTime: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        return label
    }()
    
    private let generes: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        return label
    }()
    
    private let storyLineTitle: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "\(DefaultValuesString.defaultFont.localized)", size: CustomFontSizes.titleMid)
        label.textColor = .white
        return label
    }()
    
    private let storyLine: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "\(DefaultValuesString.defaultFont.localized)", size: CustomFontSizes.title)
        label.textAlignment = NSTextAlignment.justified
        label.textColor = .white
        return label
    }()
    
    private let spokenLanguages: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "\(DefaultValuesString.defaultFont.localized)", size: CustomFontSizes.parragraph)
        label.textColor = .white
        return label
    }()
    
    private let companiesCollectionView: ProductionCompaniesCollectionView = {
        let view = ProductionCompaniesCollectionView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.cardsBackgroundLight
        return view
    }()
    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    private let favoriteButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .none
        button.setTitleColor(.white, for: .normal)
        button.tintColor = .white
        button.addTarget(self, action: #selector(addFavorite), for: .touchDown)
        return button
    }()
    
    private let dismissDetails: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .none
        button.setTitleColor(.white, for: .normal)
        button.tintColor = .white
        button.addTarget(self, action: #selector(dismissModal), for: .touchDown)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.customBlackBackground
        setupScrollView()
        setUI()
        getMovieDetails(showType: showType, id: selectedMovieId)
        if let heartFillImage = UIImage(systemName: "heart.fill") {
            favoriteButton.setImage(heartFillImage, for: .normal)
        }
        
        if let circleFillImage = UIImage(systemName: "arrow.down.circle.fill") {
            dismissDetails.setImage(circleFillImage, for: .normal)
        }
    }
    
    private func setupScrollView() {
        view.addSubview(scrollView)
        NSLayoutConstraint.activate([
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    private func setUI() {
        scrollView.addSubview(mainImageContainer)
        mainImageContainer.addSubview(movieImage)
        mainImageContainer.addSubview(voteAverageView)
        mainImageContainer.addSubview(gradientFavoriteView)
        gradientFavoriteView.addSubview(gradientFavorite)
        gradientFavoriteView.addSubview(favoriteButton)
        gradientFavoriteView.addSubview(dismissDetails)
        voteAverageView.addSubview(gradientImg)
        voteAverageView.addSubview(voteAverage)
        
        scrollView.addSubview(mainDescriptionContainer)
        mainDescriptionContainer.addSubview(movieTitle)
        mainDescriptionContainer.addSubview(movieStats)
        movieStats.addArrangedSubview(releaseDate)
        mainDescriptionContainer.addSubview(storyLineTitle)
        mainDescriptionContainer.addSubview(storyLine)
        storyLine.numberOfLines = 0
        mainDescriptionContainer.addSubview(spokenLanguages)
        mainDescriptionContainer.addSubview(companiesCollectionView)
        
        NSLayoutConstraint.activate([
            mainImageContainer.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mainImageContainer.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            mainImageContainer.topAnchor.constraint(equalTo: scrollView.topAnchor),
            mainImageContainer.heightAnchor.constraint(equalToConstant: view.bounds.height/2),
            
            movieImage.leadingAnchor.constraint(equalTo: mainImageContainer.leadingAnchor),
            movieImage.trailingAnchor.constraint(equalTo: mainImageContainer.trailingAnchor),
            movieImage.topAnchor.constraint(equalTo: mainImageContainer.topAnchor),
            movieImage.bottomAnchor.constraint(equalTo: mainImageContainer.bottomAnchor),
            
            gradientFavoriteView.leadingAnchor.constraint(equalTo: mainImageContainer.leadingAnchor),
            gradientFavoriteView.trailingAnchor.constraint(equalTo: mainImageContainer.trailingAnchor),
            gradientFavoriteView.heightAnchor.constraint(equalToConstant: 50),
            gradientFavoriteView.topAnchor.constraint(equalTo: mainImageContainer.topAnchor),
            
            gradientFavorite.leadingAnchor.constraint(equalTo: gradientFavoriteView.leadingAnchor),
            gradientFavorite.trailingAnchor.constraint(equalTo: gradientFavoriteView.trailingAnchor),
            gradientFavorite.topAnchor.constraint(equalTo: gradientFavoriteView.topAnchor),
            gradientFavorite.bottomAnchor.constraint(equalTo: gradientFavoriteView.bottomAnchor),
            
            favoriteButton.trailingAnchor.constraint(equalTo: gradientFavoriteView.trailingAnchor, constant: -20),
            favoriteButton.topAnchor.constraint(equalTo: gradientFavoriteView.topAnchor),
            favoriteButton.bottomAnchor.constraint(equalTo: gradientFavoriteView.bottomAnchor),
            
            dismissDetails.leadingAnchor.constraint(equalTo: gradientFavoriteView.leadingAnchor, constant: 20),
            dismissDetails.topAnchor.constraint(equalTo: gradientFavoriteView.topAnchor),
            dismissDetails.bottomAnchor.constraint(equalTo: gradientFavoriteView.bottomAnchor),
            
            voteAverageView.leadingAnchor.constraint(equalTo: mainImageContainer.leadingAnchor),
            voteAverageView.trailingAnchor.constraint(equalTo: mainImageContainer.trailingAnchor),
            voteAverageView.heightAnchor.constraint(equalToConstant: 50),
            voteAverageView.bottomAnchor.constraint(equalTo: mainImageContainer.bottomAnchor),
            
            gradientImg.leadingAnchor.constraint(equalTo: voteAverageView.leadingAnchor),
            gradientImg.trailingAnchor.constraint(equalTo: voteAverageView.trailingAnchor),
            gradientImg.topAnchor.constraint(equalTo: voteAverageView.topAnchor),
            gradientImg.bottomAnchor.constraint(equalTo: voteAverageView.bottomAnchor),
            
            voteAverage.leadingAnchor.constraint(equalTo: voteAverageView.leadingAnchor),
            voteAverage.trailingAnchor.constraint(equalTo: voteAverageView.trailingAnchor, constant: -10),
            voteAverage.topAnchor.constraint(equalTo: voteAverageView.topAnchor),
            voteAverage.bottomAnchor.constraint(equalTo: voteAverageView.bottomAnchor),
            
            mainDescriptionContainer.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mainDescriptionContainer.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            mainDescriptionContainer.topAnchor.constraint(equalTo: mainImageContainer.bottomAnchor),
            mainDescriptionContainer.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            
            movieTitle.leadingAnchor.constraint(equalTo: mainDescriptionContainer.leadingAnchor, constant: 10),
            movieTitle.trailingAnchor.constraint(equalTo: mainDescriptionContainer.trailingAnchor, constant: -10),
            movieTitle.topAnchor.constraint(equalTo: mainDescriptionContainer.topAnchor, constant: 20),
            movieTitle.heightAnchor.constraint(equalToConstant: 100),
            
            movieStats.leadingAnchor.constraint(equalTo: mainDescriptionContainer.leadingAnchor, constant: 10),
            movieStats.trailingAnchor.constraint(equalTo: mainDescriptionContainer.trailingAnchor, constant: -10),
            movieStats.topAnchor.constraint(equalTo: movieTitle.bottomAnchor),
            movieStats.heightAnchor.constraint(equalToConstant: 50),
            
            releaseDate.trailingAnchor.constraint(equalTo: movieStats.leadingAnchor),
            releaseDate.leadingAnchor.constraint(equalTo: movieStats.leadingAnchor),
            releaseDate.topAnchor.constraint(equalTo: movieStats.topAnchor),
            releaseDate.bottomAnchor.constraint(equalTo: movieStats.bottomAnchor),
            
            storyLineTitle.leadingAnchor.constraint(equalTo: mainDescriptionContainer.leadingAnchor, constant: 10),
            storyLineTitle.trailingAnchor.constraint(equalTo: mainDescriptionContainer.trailingAnchor, constant: -10),
            storyLineTitle.topAnchor.constraint(equalTo: movieStats.bottomAnchor),
            storyLineTitle.heightAnchor.constraint(equalToConstant: 50),
            
            storyLine.leadingAnchor.constraint(equalTo: mainDescriptionContainer.leadingAnchor, constant: 10),
            storyLine.trailingAnchor.constraint(equalTo: mainDescriptionContainer.trailingAnchor, constant: -10),
            storyLine.topAnchor.constraint(equalTo: storyLineTitle.bottomAnchor),
            storyLine.bottomAnchor.constraint(lessThanOrEqualTo: spokenLanguages.topAnchor, constant: -10),
            
            spokenLanguages.leadingAnchor.constraint(equalTo: mainDescriptionContainer.leadingAnchor, constant: 10),
            spokenLanguages.trailingAnchor.constraint(equalTo: mainDescriptionContainer.trailingAnchor, constant: -10),
            spokenLanguages.topAnchor.constraint(equalTo: storyLine.bottomAnchor),
            spokenLanguages.heightAnchor.constraint(equalToConstant: 50),
            
            companiesCollectionView.leadingAnchor.constraint(equalTo: mainDescriptionContainer.leadingAnchor),
            companiesCollectionView.trailingAnchor.constraint(equalTo: mainDescriptionContainer.trailingAnchor),
            companiesCollectionView.topAnchor.constraint(equalTo: spokenLanguages.bottomAnchor),
            companiesCollectionView.heightAnchor.constraint(equalToConstant: 100),
            companiesCollectionView.bottomAnchor.constraint(equalTo: mainDescriptionContainer.bottomAnchor),
        ])
    }

    
    func getMovieDetails(showType: String, id: Int) {
        detailsViewModel.fetchMovies(showType: showType, id: id) { [weak self] movieDetails in
            var showName = ""
            var showDate = ""
            var showDuration = 0
            if showType == "\(DefaultValuesString.defaultMovie.localized)" {
                showName = movieDetails.originalTitle ?? ""
                showDate = movieDetails.releaseDate ?? ""
                showDuration = movieDetails.runtime ?? 0
            } else if showType == "\(DefaultValuesString.defaultTv.localized)" {
                showName = movieDetails.name ?? ""
                showDate = movieDetails.first_air_date ?? ""
                showDuration = 0
            }
            
            guard let moviePoster = movieDetails.posterPath else { return }
            let movieTitle = showName
            let releaseDate = showDate
            guard let formattedYear = DateFormatterHelperYear.formatYearFromDate(dateString: "\(releaseDate)") else { return }
            let runTime = showDuration
            let formattedTime = TimeFormatterHelper.formatTimeFromMinutes(minutes: runTime)
            guard let generes = movieDetails.genres else { return }
            guard let spokenLang = movieDetails.spokenLanguages else { return }
            guard let storyLine = movieDetails.overview else { return }
            guard let voteAverage = movieDetails.voteAverage else { return }
            guard let productionCompany = movieDetails.productionCompanies else { return }
            
            
            if let productionCompanies = movieDetails.productionCompanies {
                self?.companiesCollectionView.configure(with: productionCompany)
             }

            var allGeneres = ""
            for i in 0..<generes.count {
                allGeneres += generes[i].name ?? ""
                if i < 2 && i < generes.count - 1 {
                    allGeneres += ", "
                }
            }
            
            var allSpoken = ""
            for i in 0..<spokenLang.count {
                allSpoken += spokenLang[i].name ?? ""
                if i < spokenLang.count - 1 {
                    allSpoken += ", "
                }
            }
            
            if let url = URL(string: "\(DefaultValuesString.urlImages.localized)\(moviePoster)") {
                    ImageLoader.loadImage(from: url.absoluteString) { loadedImage in
                        DispatchQueue.main.async {
                            self?.movieImage.image = loadedImage
                            self?.movieTitle.text = movieTitle
                            self?.releaseDate.text = "\(formattedYear) - \(formattedTime) hrs - \(allGeneres)"
                            self?.spokenLanguages.text = allSpoken
                            self?.storyLine.text = storyLine
                            self?.voteAverage.text = "★ \(String(format: "%.1f", voteAverage))"
                        }
                    }
                } else {
                    print("\(ErrorStrings.invaludURL.localized)")
                }
        }
    }
    
    @objc func addFavorite(){
        print("add favorite")
    }
    
    @objc func dismissModal(){
        dismiss(animated: true, completion: nil)
    }
}
