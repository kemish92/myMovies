//
//  ProductionCompaniesCollectionView.swift
//  myMovies
//
//  Created by Alberto Kemish Flores Macias on 8/13/23.
//

import UIKit

class ProductionCompaniesCollectionView: UIView, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    private var productionCompanies: [ProductionCompany] = []
    private var collectionView: UICollectionView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupCollectionView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupCollectionView()
    }
    
    private func setupCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        
        collectionView = UICollectionView(frame: bounds, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(CompanyLogoCollectionViewCell.self, forCellWithReuseIdentifier: "CompanyLogoCell")
        
        addSubview(collectionView)
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            collectionView.topAnchor.constraint(equalTo: topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    func configure(with productionCompanies: [ProductionCompany]) {
        self.productionCompanies = productionCompanies
        collectionView.reloadData()
    }
    
    // MARK: UICollectionViewDataSource
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return productionCompanies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CompanyLogoCell", for: indexPath) as! CompanyLogoCollectionViewCell
        let company = productionCompanies[indexPath.item]
        cell.configure(with: company.logoPath ?? "")
        return cell
    }
    
    // MARK: UICollectionViewDelegateFlowLayout
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 100, height: collectionView.bounds.height)
    }
}

class CompanyLogoCollectionViewCell: UICollectionViewCell {
    private let logoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupViews()
    }
    
    private func setupViews() {
        addSubview(logoImageView)
        NSLayoutConstraint.activate([
            logoImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            logoImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15),
            logoImageView.topAnchor.constraint(equalTo: topAnchor, constant: 20),
            logoImageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -20)
        ])
    }
    
    func configure(with logoPath: String) {
        if let url = URL(string: "\(DefaultValuesString.urlImages.localized)\(logoPath)") {
            ImageLoader.loadImage(from: url.absoluteString) { [weak self] loadedImage in
                DispatchQueue.main.async {
                    self?.logoImageView.image = loadedImage
                }
            }
        } else {
            print("Error")
        }
    }
}

