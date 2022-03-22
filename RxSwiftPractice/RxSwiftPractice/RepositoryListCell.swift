//
//  RepositoryListCell.swift
//  RxSwiftPractice
//
//  Created by 유준용 on 2022/03/22.
//

import UIKit

class RepositoryListCell: UITableViewCell {
    var repository: Repository?
    
    let nameLabel = UILabel()
    let descriptionLabel = UILabel()
    let starImageView = UIImageView()
    let starLabel = UILabel()
    let languageLabel = UILabel()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        configureUI()
        
        guard let repository = repository else {
            return
        }
        nameLabel.text = repository.name
        nameLabel.font = .systemFont(ofSize: 20, weight: .bold)
        
        descriptionLabel.text = repository.description
        descriptionLabel.font = .systemFont(ofSize: 15)
        descriptionLabel.numberOfLines = 2
        
        starImageView.image = UIImage(systemName: "star")
        starLabel.text = String(repository.stargazersCount)
        starLabel.font = .systemFont(ofSize: 16)
        starLabel.textColor = .gray
        
        languageLabel.text = repository.language
        languageLabel.font = .systemFont(ofSize: 16)
        languageLabel.textColor = .gray
    }
    
    private func configureUI(){
        
        // nameLabel
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(nameLabel)
        NSLayoutConstraint.activate([
            nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            nameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            nameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20)
        ])
        
        // descriptionLabel
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(descriptionLabel)
        NSLayoutConstraint.activate([
            descriptionLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            descriptionLabel.trailingAnchor.constraint(equalTo: nameLabel.trailingAnchor),
            descriptionLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 5)
            ])
        
        // starImageView
        starImageView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(starImageView)
        NSLayoutConstraint.activate([
            starImageView.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 10),
            starImageView.leadingAnchor.constraint(equalTo: descriptionLabel.leadingAnchor),
            starImageView.widthAnchor.constraint(equalToConstant: 20),
            starImageView.heightAnchor.constraint(equalToConstant: 20),
        ])
        
        // starLabel
        starLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(starLabel)
        NSLayoutConstraint.activate([
            starLabel.centerYAnchor.constraint(equalTo: starImageView.centerYAnchor),
            starLabel.leadingAnchor.constraint(equalTo: starImageView.trailingAnchor, constant: 5)
        ])

        // languageLabel
        languageLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(languageLabel)
        NSLayoutConstraint.activate([
            languageLabel.centerYAnchor.constraint(equalTo: starLabel.centerYAnchor),
            languageLabel.leadingAnchor.constraint(equalTo: starLabel.trailingAnchor, constant: 15)
        ])
    }

    
}
