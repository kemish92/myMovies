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
        let imageName = "default.jpeg"
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
        label.text = "Movie title"
        label.numberOfLines = 2
        label.font = UIFont(name: "AppleSDGothicNeo-Bold", size: CustomFontSizes.titleLarge)
        label.textColor = .white
        return label
    }()
    
    private let voteAverageView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let gradientImg: UIImageView = {
        let imageName = "gradient.png"
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
        label.text = "★ 8.0"
        label.textAlignment = .right
        label.font = UIFont(name: "AppleSDGothicNeo-Bold", size: CustomFontSizes.titleLarge)
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
        label.text = "2023"
        label.numberOfLines = 0
        label.textColor = UIColor.cardsTitle
        return label
    }()
    
    private let runTime: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "1:30 hrs"
        label.textColor = .white
        return label
    }()
    
    private let generes: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "action, adventure"
        label.textColor = .white
        return label
    }()
    
    private let storyLineTitle: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Story Line"
        label.font = UIFont(name: "AppleSDGothicNeo-Bold", size: CustomFontSizes.titleMid)
        label.textColor = .white
        return label
    }()
    
    private let storyLine: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = ""
        label.font = UIFont(name: "AppleSDGothicNeo-Bold", size: CustomFontSizes.title)
        label.textAlignment = NSTextAlignment.justified
        label.textColor = .white
        return label
    }()
    
    private let spokenLanguages: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = ""
        label.font = UIFont(name: "AppleSDGothicNeo-Bold", size: CustomFontSizes.parragraph)
        label.textColor = .white
        return label
    }()
    
    private let companiesCollectionView: ProductionCompaniesCollectionView = {
        let view = ProductionCompaniesCollectionView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.cardsBackgroundLight
        return view
    }()
    

    
    //original_title //vote_average
    //release_date //runtime //genres[]
    //Story Line
    //overview
    //spoken_languages []
    //production_companies[] //Collection view horizontal
    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.customBlackBackground
        setupScrollView()
        setUI()
        getMovieDetails(id: selectedMovieId)
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
        voteAverageView.addSubview(gradientImg)
        voteAverageView.addSubview(voteAverage)
        
        scrollView.addSubview(mainDescriptionContainer)
        mainDescriptionContainer.addSubview(movieTitle)
        mainDescriptionContainer.addSubview(movieStats)
        movieStats.addArrangedSubview(releaseDate)
        mainDescriptionContainer.addSubview(storyLineTitle)
        mainDescriptionContainer.addSubview(storyLine)
        storyLine.numberOfLines = 0 // Allow multiple lines
        mainDescriptionContainer.addSubview(spokenLanguages)
        mainDescriptionContainer.addSubview(companiesCollectionView)
        
        NSLayoutConstraint.activate([
            // Constraints for mainImageContainer
            mainImageContainer.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mainImageContainer.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            mainImageContainer.topAnchor.constraint(equalTo: scrollView.topAnchor),
            mainImageContainer.heightAnchor.constraint(equalToConstant: view.bounds.height/2),
            
            // Constraints for movieImage
            movieImage.leadingAnchor.constraint(equalTo: mainImageContainer.leadingAnchor),
            movieImage.trailingAnchor.constraint(equalTo: mainImageContainer.trailingAnchor),
            movieImage.topAnchor.constraint(equalTo: mainImageContainer.topAnchor),
            movieImage.bottomAnchor.constraint(equalTo: mainImageContainer.bottomAnchor),
            
            // Constraints for voteAverageView
            voteAverageView.leadingAnchor.constraint(equalTo: mainImageContainer.leadingAnchor),
            voteAverageView.trailingAnchor.constraint(equalTo: mainImageContainer.trailingAnchor),
            voteAverageView.heightAnchor.constraint(equalToConstant: 50),
            voteAverageView.bottomAnchor.constraint(equalTo: mainImageContainer.bottomAnchor),
            
            // Constraints for gradientImg
            gradientImg.leadingAnchor.constraint(equalTo: voteAverageView.leadingAnchor),
            gradientImg.trailingAnchor.constraint(equalTo: voteAverageView.trailingAnchor),
            gradientImg.topAnchor.constraint(equalTo: voteAverageView.topAnchor),
            gradientImg.bottomAnchor.constraint(equalTo: voteAverageView.bottomAnchor),
            
            // Constraints for voteAverage
            voteAverage.leadingAnchor.constraint(equalTo: voteAverageView.leadingAnchor),
            voteAverage.trailingAnchor.constraint(equalTo: voteAverageView.trailingAnchor, constant: -10),
            voteAverage.topAnchor.constraint(equalTo: voteAverageView.topAnchor),
            voteAverage.bottomAnchor.constraint(equalTo: voteAverageView.bottomAnchor),
            
            // Constraints for mainDescriptionContainer
            mainDescriptionContainer.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mainDescriptionContainer.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            mainDescriptionContainer.topAnchor.constraint(equalTo: mainImageContainer.bottomAnchor),
            mainDescriptionContainer.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            
            // Constraints for movieTitle
            movieTitle.leadingAnchor.constraint(equalTo: mainDescriptionContainer.leadingAnchor, constant: 10),
            movieTitle.trailingAnchor.constraint(equalTo: mainDescriptionContainer.trailingAnchor, constant: -10),
            movieTitle.topAnchor.constraint(equalTo: mainDescriptionContainer.topAnchor, constant: 20),
            movieTitle.heightAnchor.constraint(equalToConstant: 100),
            
            // Constraints for movieStats
            movieStats.leadingAnchor.constraint(equalTo: mainDescriptionContainer.leadingAnchor, constant: 10),
            movieStats.trailingAnchor.constraint(equalTo: mainDescriptionContainer.trailingAnchor, constant: -10),
            movieStats.topAnchor.constraint(equalTo: movieTitle.bottomAnchor),
            movieStats.heightAnchor.constraint(equalToConstant: 50),
            
            
            releaseDate.trailingAnchor.constraint(equalTo: movieStats.leadingAnchor),
            releaseDate.leadingAnchor.constraint(equalTo: movieStats.leadingAnchor),
            releaseDate.topAnchor.constraint(equalTo: movieStats.topAnchor),
            releaseDate.bottomAnchor.constraint(equalTo: movieStats.bottomAnchor),
            
            // Constraints for storyLineTitle
            storyLineTitle.leadingAnchor.constraint(equalTo: mainDescriptionContainer.leadingAnchor, constant: 10),
            storyLineTitle.trailingAnchor.constraint(equalTo: mainDescriptionContainer.trailingAnchor, constant: -10),
            storyLineTitle.topAnchor.constraint(equalTo: movieStats.bottomAnchor),
            storyLineTitle.heightAnchor.constraint(equalToConstant: 50),
            
            // Constraints for storyLine
            // Constraint for dynamic storyLine height
            storyLine.leadingAnchor.constraint(equalTo: mainDescriptionContainer.leadingAnchor, constant: 10),
            storyLine.trailingAnchor.constraint(equalTo: mainDescriptionContainer.trailingAnchor, constant: -10),
            storyLine.topAnchor.constraint(equalTo: storyLineTitle.bottomAnchor),
            storyLine.bottomAnchor.constraint(lessThanOrEqualTo: spokenLanguages.topAnchor, constant: -10), // Optional spacing between elements
            
            // Constraints for spokenLanguages
            spokenLanguages.leadingAnchor.constraint(equalTo: mainDescriptionContainer.leadingAnchor, constant: 10),
            spokenLanguages.trailingAnchor.constraint(equalTo: mainDescriptionContainer.trailingAnchor, constant: -10),
            spokenLanguages.topAnchor.constraint(equalTo: storyLine.bottomAnchor),
            spokenLanguages.heightAnchor.constraint(equalToConstant: 50),
            
            // Constraints for companiesCollectionView
            
            companiesCollectionView.leadingAnchor.constraint(equalTo: mainDescriptionContainer.leadingAnchor),
            companiesCollectionView.trailingAnchor.constraint(equalTo: mainDescriptionContainer.trailingAnchor),
            companiesCollectionView.topAnchor.constraint(equalTo: spokenLanguages.bottomAnchor),
            companiesCollectionView.heightAnchor.constraint(equalToConstant: 100),
            companiesCollectionView.bottomAnchor.constraint(equalTo: mainDescriptionContainer.bottomAnchor),
            

        ])
        
        

         

    }

    
    func getMovieDetails(id: Int) {
        //original_title //vote_average
        //release_date //runtime //genres[]
        //Story Line
        //overview
        //spoken_languages []
        //production_companies[] //Collection view horizontal
        
        
        detailsViewModel.fetchMovies(id: id) { [weak self] movieDetails in
            var movieTitle = movieDetails.originalTitle
            guard let moviePoster = movieDetails.posterPath else { return }
            guard let movieTitle = movieDetails.originalTitle else { return }
            guard let releaseDate = movieDetails.releaseDate else { return }
            guard let formattedYear = DateFormatterHelperYear.formatYearFromDate(dateString: "\(releaseDate)") else { return }
            guard let runTime = movieDetails.runtime else { return }
            let formattedTime = TimeFormatterHelper.formatTimeFromMinutes(minutes: runTime)
            guard let generes = movieDetails.genres else { return }
            guard let spokenLang = movieDetails.spokenLanguages else { return }
            guard let storyLine = movieDetails.overview else { return }
            
            guard let productionCompany = movieDetails.productionCompanies else { return }
            
            
            if let productionCompanies = movieDetails.productionCompanies {
                self?.companiesCollectionView.configure(with: productionCompany)
             }
            
       
            
            
            print("productionCompany \(productionCompany)")
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
            ///71BqEFAF4V3qjjMPCpLuyJFB9A.png
                if let url = URL(string: "https://image.tmdb.org/t/p/original\(moviePoster)") {
                    ImageLoader.loadImage(from: url.absoluteString) { loadedImage in
                        DispatchQueue.main.async {
                            self?.movieImage.image = loadedImage
                            self?.movieTitle.text = movieTitle
                            self?.releaseDate.text = "\(formattedYear) - \(formattedTime) hrs - \(allGeneres)"
                            self?.spokenLanguages.text = allSpoken
                            self?.storyLine.text = storyLine
                        }
                    }
                } else {
                    print("\(ErrorStrings.invaludURL.localized)")
                }
            //}
        }
    }
}
