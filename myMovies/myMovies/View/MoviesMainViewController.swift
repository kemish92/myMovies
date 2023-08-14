//
//  MoviesMainViewController.swift
//  myMovies
//
//  Created by Alberto Kemish Flores Macias on 8/11/23.
//

import UIKit

class MoviesMainViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, CustomSegmentedControlDelegate {
    var customNavBarCreator: CustomNavBarCreator!
    var viewModel = MoviesViewModel()
    
    var collectionView: UICollectionView!
    
    var currentPage = 1
    var defaultSection = DefaultValuesString.defaultSection.localized
    var showType = DefaultValuesString.defaultShow.localized
    var isFetchingData = false
    
    private let mainBackground: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.customBlackBackground
        return view
    }()
    
    private let segmentedViewContainer: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .none
        return view
    }()
    
    private let collectionViewContainer: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .none
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
        setUI()
        setNavBar()
        setSegmentedControl()
        let layout = UICollectionViewFlowLayout()
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .none
        collectionViewContainer.addSubview(collectionView)
        NSLayoutConstraint.activate([
            collectionView.leadingAnchor.constraint(equalTo: collectionViewContainer.leadingAnchor, constant: 10),
            collectionView.trailingAnchor.constraint(equalTo: collectionViewContainer.trailingAnchor, constant: -10),
            collectionView.topAnchor.constraint(equalTo: collectionViewContainer.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: collectionViewContainer.bottomAnchor)
        ])
        
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(CustomCell.self, forCellWithReuseIdentifier: "cell")
        
        getMovies()
    }
    
    func getMovies() {
        guard !isFetchingData else { return }
        isFetchingData = true
        
        viewModel.fetchMovies(showType: showType, defaultSection: defaultSection, page: currentPage) { [weak self] in
            self?.isFetchingData = false
            self?.collectionView.reloadData()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfItems()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CustomCell
        
        if let movie = viewModel.movieAtIndex(indexPath.row) {
            if let posterPath = movie.posterPath {
                if let url = URL(string: "\(DefaultValuesString.urlImages.localized)\(posterPath)") {
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
                    print("\(ErrorStrings.invaludURL.localized)")
                }
            }
            
            if showType == DefaultValuesString.defaultMovie.localized {
                cell.movieTitle.text = movie.originalTitle
                let formattedDateStr = DateFormatterHelper.convertDate(movie.releaseDate ?? "")
                cell.date.text = formattedDateStr
            } else if showType == DefaultValuesString.defaultTv.localized {
                cell.movieTitle.text = movie.name
                let formattedDateStr = DateFormatterHelper.convertDate(movie.first_air_date ?? "")
                cell.date.text = formattedDateStr
            }
            cell.score.text = "★ \(movie.voteAverage ?? 0.0)"
            cell.descriptionText.text = movie.overview
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width/2 - 20, height: 350)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let selectedMovie = viewModel.movieAtIndex(indexPath.row) {
            guard let selectedMovieId = selectedMovie.id else { return }
            let movieDetailsVC = MovieDetailsViewController()
            movieDetailsVC.selectedMovieId = selectedMovieId
            movieDetailsVC.showType = self.showType
            self.present(movieDetailsVC, animated: true, completion: nil)
        }
    }
    
    func setNavBar(){
        view.backgroundColor = UIColor.customGrayForNavBar
        customNavBarCreator = CustomNavBarCreator()
        customNavBarCreator.navigationButton(viewController: self, title: MainMoviesStrings.mainMoviesTitle.localized, titleFontSize: CustomFontSizes.title)
    }
    
    func setSegmentedControl(){
        let items = [MainMoviesStrings.popular.localized, MainMoviesStrings.topRated.localized, MainMoviesStrings.onTv.localized, MainMoviesStrings.airingToday.localized]
        let segmentedControlView = CustomSegmentedControlView(items: items)
        segmentedControlView.delegate = self
        segmentedControlView.translatesAutoresizingMaskIntoConstraints = false
        segmentedControlView.setTextColor(.white, backgroundColor: UIColor.customBlack, selectedSegmentColor: .lightGray)
        
        segmentedViewContainer.addSubview(segmentedControlView)
        segmentedControlView.segmentedControl.addTarget(segmentedControlView, action: #selector(CustomSegmentedControlView.changeSelector(
            _:)), for: .valueChanged)
        
        NSLayoutConstraint.activate([
            segmentedControlView.centerXAnchor.constraint(equalTo: segmentedViewContainer.centerXAnchor),
            segmentedControlView.centerYAnchor.constraint(equalTo: segmentedViewContainer.centerYAnchor),
            segmentedControlView.widthAnchor.constraint(equalTo: segmentedViewContainer.widthAnchor, multiplier: 0.9)
        ])
    }
    
    func segmentedControlDidChange(to index: Int) {
         var apiEndpoint = ""
        var apiShow = ""

         switch index {
         case 0:
             apiEndpoint = "\(DefaultValuesString.apiEndpointPopular.localized)"
             apiShow = "\(DefaultValuesString.defaultMovie.localized)"
         case 1:
             apiEndpoint = "\(DefaultValuesString.apiEndpointTopRated.localized)"
             apiShow = "\(DefaultValuesString.defaultMovie.localized)"
         case 2:
             apiEndpoint = "\(DefaultValuesString.apiEndpointOnTheAir.localized)"
             apiShow = "\(DefaultValuesString.defaultTv.localized)"
         case 3:
             apiEndpoint = "\(DefaultValuesString.apiEndpointAiringToday.localized)"
             apiShow = "\(DefaultValuesString.defaultTv.localized)"
         default:
             break
         }

        defaultSection = apiEndpoint
        showType = apiShow
        currentPage = 1
        getMovies()
     }
    
    private func setUI(){
        view.addSubview(mainBackground)
        NSLayoutConstraint.activate([
            mainBackground.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mainBackground.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            mainBackground.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            mainBackground.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        view.addSubview(segmentedViewContainer)
        NSLayoutConstraint.activate([
            segmentedViewContainer.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            segmentedViewContainer.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            segmentedViewContainer.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            segmentedViewContainer.heightAnchor.constraint(equalToConstant: 80)
        ])
        
        view.addSubview(collectionViewContainer)
        NSLayoutConstraint.activate([
            collectionViewContainer.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionViewContainer.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionViewContainer.topAnchor.constraint(equalTo: segmentedViewContainer.bottomAnchor),
            collectionViewContainer.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}


extension MoviesMainViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let screenHeight = scrollView.frame.size.height
        
        if offsetY > contentHeight - screenHeight * 2 {
            currentPage += 1
            getMovies()
        }
    }
}
