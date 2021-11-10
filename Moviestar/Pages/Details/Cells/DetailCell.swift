//
//  DetailCell.swift
//  Moviestar
//
//  Created by Victor Pedersen on 10/11/2021.
//

import UIKit
import Entities
import Spring

final class DetailCell: UITableViewCell {
 
    // MARK: - Properties
    var movie: MovieCell.ViewModel! {
        didSet {
            // Updating all the values for this cell.
            if let posterPath = movie.poster_path {
                var url = "https://image.tmdb.org/t/p/w500"
                url += posterPath
                coverImageView.downloaded(from: url, contentMode: .scaleAspectFill)
            }
            
            releaseDateLabel.text = "Release date: \(movie.release_date)"
            
            for genre in movie.genre_ids {
                // Implement fetch for genres and update genreLabel
                
            }
            
            originalLangueView.text = movie.original_language
            overviewLabel.text = movie.overview
            
            
        }
    }
    
    private let coverImageView: SpringImageView = {
        let imageView = SpringImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        imageView.autostart = false
        imageView.animation = "pop"
        imageView.force = 0.3
        imageView.velocity = 0.9
        return imageView
    }()
    
    private let darkOverlay: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.black
        view.alpha = 0.25
        return view
    }()
    
    private let releaseDateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 14, weight: .thin)
        label.textColor = .midnightGreen
        return label
    }()
    
    private let originalLangueView: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 14, weight: .light)
        label.textColor = .midnightGreen
        label.textAlignment = .center
        label.layer.masksToBounds = true
        label.layer.cornerRadius = 6
        label.backgroundColor = UIColor.champagne.withAlphaComponent(0.5)
        return label
    }()
    
    private let overviewLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 14, weight: .light)
        label.textColor = .midnightGreen
        label.textAlignment = .left
        label.numberOfLines = 0
        
        return label
    }()
    
    private let stackViewHorizontalInformation: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.distribution = .fillProportionally
        return stackView
    }()
    
    private let stackViewInformation: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 10
        return stackView
    }()

    
    // MARK: - Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureThis()
        configureSubviews()
        configureConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Handlers
    private func configureThis() {
        selectionStyle = .none
        backgroundColor = .clear
    }
    
    private func configureSubviews() {
        
        stackViewHorizontalInformation.addArrangedSubview(releaseDateLabel)
        stackViewHorizontalInformation.addArrangedSubview(originalLangueView)
        
        stackViewInformation.addArrangedSubview(stackViewHorizontalInformation)
        stackViewInformation.addArrangedSubview(overviewLabel)
        
        contentView.addSubview(coverImageView)
        contentView.addSubview(darkOverlay)
        contentView.addSubview(stackViewInformation)
        
    }
    
    private func configureConstraints() {
        
        NSLayoutConstraint.activate([
            
            darkOverlay.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            darkOverlay.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            darkOverlay.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width),
            darkOverlay.heightAnchor.constraint(equalToConstant: 300),
        
            coverImageView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            coverImageView.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            coverImageView.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width),
            coverImageView.heightAnchor.constraint(equalToConstant: 300),
            
            stackViewInformation.topAnchor.constraint(equalTo: coverImageView.bottomAnchor, constant: 20),
            stackViewInformation.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 20),
            stackViewInformation.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -20),
            stackViewInformation.heightAnchor.constraint(lessThanOrEqualToConstant: 300),
        
        ])
    }
}

