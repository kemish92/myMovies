//
//  MoviesMainViewController.swift
//  myMovies
//
//  Created by Alberto Kemish Flores Macias on 8/11/23.
//

import UIKit

class MoviesMainViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    var customNavBarCreator: CustomNavBarCreator!
    
    let cats = ["Cat1", "Cat2", "Cat3", "Cat4", "Cat5", "Cat1", "Cat2", "Cat3", "Cat4", "Cat5"]
    var collectionView: UICollectionView!
    
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
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cats.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CustomCell
        cell.movieImage.image = UIImage(named: cats[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width/2 - 20, height: 350)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("Cat \(indexPath.row)")
        self.present(MovieDetailsViewController(), animated: true, completion: nil)
    }
    
    func setNavBar(){
        view.backgroundColor = UIColor.customGrayForNavBar
        customNavBarCreator = CustomNavBarCreator()
        customNavBarCreator.navigationButton(viewController: self, title: MainMoviesStrings.mainMoviesTitle.localized, titleFontSize: CustomFontSizes.title)
    }
    
    func setSegmentedControl(){
        let items = [MainMoviesStrings.popular.localized, MainMoviesStrings.topRated.localized, MainMoviesStrings.onTv.localized, MainMoviesStrings.airingToday.localized]
        let segmentedControlView = CustomSegmentedControlView(items: items)
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

