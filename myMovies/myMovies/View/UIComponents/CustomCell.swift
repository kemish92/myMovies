//
//  CustomCell.swift
//  myMovies
//
//  Created by Alberto Kemish Flores Macias on 8/11/23.
//

import UIKit

class CustomCell: UICollectionViewCell {
    private let cellContainer: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.cardsBackground
        view.layer.cornerRadius = 20
        return view
    }()
    
    private let imageContainer: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 20
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
    
    private let movieTitleView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let movieTitle: UILabel = {
        let label = UILabel()
        label.text = ""
        label.textColor = UIColor.cardsTitle
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "\(DefaultValuesString.defaultFont.localized)", size: CustomFontSizes.subTitle)
        return label
    }()
    
    private let dateScoreView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let dateScoreStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.distribution = .fillProportionally
        return stackView
    }()
    
    private let dateView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let date: UILabel = {
        let label = UILabel()
        label.text = ""
        label.textColor = UIColor.cardsTitle
        label.font = UIFont(name: "\(DefaultValuesString.defaultFont.localized)", size: CustomFontSizes.subTitle)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let scoreView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let score: UILabel = {
        let label = UILabel()
        label.text = ""
        label.textColor = UIColor.cardsTitle
        label.font = UIFont(name: "\(DefaultValuesString.defaultFont.localized)", size: CustomFontSizes.subTitle)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let descriptionView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    var descriptionText: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = ""
        label.textColor = .white
        label.font = UIFont(name: "\(DefaultValuesString.defaultFont.localized)", size: CustomFontSizes.parragraph)
        label.numberOfLines = 8
        return label
    }()
    
    override init (frame: CGRect) {
        super.init(frame: frame)
        addSubview(cellContainer)
        NSLayoutConstraint.activate([
            cellContainer.leadingAnchor.constraint(equalTo: leadingAnchor),
            cellContainer.trailingAnchor.constraint(equalTo: trailingAnchor),
            cellContainer.topAnchor.constraint(equalTo: topAnchor),
            cellContainer.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
        
        cellContainer.addSubview(imageContainer)
        NSLayoutConstraint.activate([
            imageContainer.leadingAnchor.constraint(equalTo: cellContainer.leadingAnchor),
            imageContainer.trailingAnchor.constraint(equalTo: cellContainer.trailingAnchor),
            imageContainer.topAnchor.constraint(equalTo: cellContainer.topAnchor),
            imageContainer.heightAnchor.constraint(equalToConstant: 200)
        ])
        
        imageContainer.addSubview(movieImage)
        NSLayoutConstraint.activate([
            movieImage.leadingAnchor.constraint(equalTo: imageContainer.leadingAnchor),
            movieImage.trailingAnchor.constraint(equalTo: imageContainer.trailingAnchor),
            movieImage.topAnchor.constraint(equalTo: imageContainer.topAnchor),
            movieImage.bottomAnchor.constraint(equalTo: imageContainer.bottomAnchor)
        ])
        
        cellContainer.addSubview(movieTitleView)
        NSLayoutConstraint.activate([
            movieTitleView.leadingAnchor.constraint(equalTo: imageContainer.leadingAnchor),
            movieTitleView.trailingAnchor.constraint(equalTo: imageContainer.trailingAnchor),
            movieTitleView.topAnchor.constraint(equalTo: imageContainer.bottomAnchor, constant: 5),
            movieTitleView.heightAnchor.constraint(equalToConstant: 30)
        ])
        
        movieTitleView.addSubview(movieTitle)
        NSLayoutConstraint.activate([
            movieTitle.leadingAnchor.constraint(equalTo: movieTitleView.leadingAnchor, constant: 8),
            movieTitle.trailingAnchor.constraint(equalTo: movieTitleView.trailingAnchor, constant: -8),
            movieTitle.topAnchor.constraint(equalTo: movieTitleView.topAnchor),
            movieTitle.bottomAnchor.constraint(equalTo: movieTitleView.bottomAnchor)
        ])
        
        cellContainer.addSubview(dateScoreView)
        NSLayoutConstraint.activate([
            dateScoreView.leadingAnchor.constraint(equalTo: cellContainer.leadingAnchor),
            dateScoreView.trailingAnchor.constraint(equalTo: cellContainer.trailingAnchor),
            dateScoreView.topAnchor.constraint(equalTo: movieTitleView.bottomAnchor, constant: 5),
            dateScoreView.heightAnchor.constraint(equalToConstant: 20)
        ])
        
        dateScoreView.addSubview(dateScoreStackView)
        NSLayoutConstraint.activate([
            dateScoreStackView.leadingAnchor.constraint(equalTo: dateScoreView.leadingAnchor),
            dateScoreStackView.trailingAnchor.constraint(equalTo: dateScoreView.trailingAnchor),
            dateScoreStackView.topAnchor.constraint(equalTo: dateScoreView.topAnchor),
            dateScoreStackView.bottomAnchor.constraint(equalTo: dateScoreView.bottomAnchor)
        ])
        
        dateScoreStackView.addArrangedSubview(dateView)
        dateView.addSubview(date)
        NSLayoutConstraint.activate([
            date.leadingAnchor.constraint(equalTo: dateView.leadingAnchor, constant: 8),
            date.trailingAnchor.constraint(equalTo: dateView.trailingAnchor),
            date.topAnchor.constraint(equalTo: dateView.topAnchor),
            date.bottomAnchor.constraint(equalTo: dateView.bottomAnchor)
        ])
        
        dateScoreStackView.addArrangedSubview(scoreView)
        scoreView.addSubview(score)
        NSLayoutConstraint.activate([
            score.leadingAnchor.constraint(equalTo: scoreView.leadingAnchor),
            score.trailingAnchor.constraint(equalTo: scoreView.trailingAnchor),
            score.topAnchor.constraint(equalTo: scoreView.topAnchor),
            score.bottomAnchor.constraint(equalTo: scoreView.bottomAnchor)
        ])
        
        cellContainer.addSubview(descriptionView)
        NSLayoutConstraint.activate([
            descriptionView.leadingAnchor.constraint(equalTo: cellContainer.leadingAnchor),
            descriptionView.trailingAnchor.constraint(equalTo: cellContainer.trailingAnchor),
            descriptionView.topAnchor.constraint(equalTo: dateScoreView.bottomAnchor),
            descriptionView.bottomAnchor.constraint(equalTo: cellContainer.bottomAnchor)
        ])
        
        descriptionView.addSubview(descriptionText)
        NSLayoutConstraint.activate([
            descriptionText.leadingAnchor.constraint(equalTo: descriptionView.leadingAnchor,constant: 8),
            descriptionText.trailingAnchor.constraint(equalTo: descriptionView.trailingAnchor, constant: -8),
            descriptionText.topAnchor.constraint(equalTo: descriptionView.topAnchor, constant: 8),
            descriptionText.bottomAnchor.constraint(equalTo: descriptionView.bottomAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("\(ErrorStrings.coderNotImplemented.localized)")
    }
}
