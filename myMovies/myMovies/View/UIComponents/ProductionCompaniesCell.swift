//
//  ProductionCompaniesCell.swift
//  myMovies
//
//  Created by Alberto Kemish Flores Macias on 8/15/23.
//

import UIKit

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
