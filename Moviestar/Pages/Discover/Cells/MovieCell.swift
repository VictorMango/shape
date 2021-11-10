//
//  MovieCell.swift
//  Moviestar
//
//  Created by Frederik Christensen on 19/01/2021.
//

import UIKit
import Entities

final class MovieCell: UICollectionViewCell {
    
    // MARK: - Properties
    let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 20, weight: .light)
        label.textColor = UIColor.midnightGreen
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    let posterImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.borderWidth = 2
        imageView.layer.borderColor = UIColor(red: 243/255.0, green: 233/255.0, blue: 210/255.0, alpha: 0.75).cgColor
        return imageView
    }()

    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: .zero)
        configureView()
        configureSubviews()
        configureConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Handlers
    private func configureView() {
        
        posterImageView.layer.cornerRadius = 15
        posterImageView.clipsToBounds = true
    }
    
    private func configureSubviews() {
        contentView.addSubview(posterImageView)
        contentView.addSubview(titleLabel)
    }

    private func configureConstraints() {
        NSLayoutConstraint.activate([
            
            titleLabel.heightAnchor.constraint(lessThanOrEqualToConstant: 200),
            titleLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 20),
            titleLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -20),
            titleLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            
            posterImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            posterImageView.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            posterImageView.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            posterImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
        ])
    }
}

extension MovieCell {
    
    struct ViewModel: Hashable {
        let id: Int
        let title: String
        let overview: String
        let original_language: String
        let release_date: String
        let genre_ids: [Int]
        let poster_path: String?
    }

    func populate(data: ViewModel) {
        
        titleLabel.text = ""
        posterImageView.backgroundColor = .clear
        
        if let poster_path = data.poster_path {
            var url = "https://image.tmdb.org/t/p/w500"
            url += poster_path
            posterImageView.downloaded(from: url, contentMode: .scaleAspectFit)
        } else {
            print(data.title)
            titleLabel.text = data.title
            posterImageView.backgroundColor = UIColor(red: 198/255, green: 218/255, blue: 191/255, alpha: 0.6)
        }
    }
}
