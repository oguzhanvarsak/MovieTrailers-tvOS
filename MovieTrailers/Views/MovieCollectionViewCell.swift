//
//  MovieCollectionViewCell.swift
//  MovieTrailers
//
//  Created by Oğuzhan Varsak on 4.06.2022.
//

import UIKit

class MovieCollectionViewCell: UICollectionViewCell {
    
    weak var dataTask: URLSessionDataTask?
    
    let titleLabel = UILabel()
    let posterImageView = UIImageView()
    
    var title: String? {
        didSet {
            configure()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()

        titleLabel.alpha = 0.0
        posterImageView.image = nil
        
    }
    
    func configure() {
        posterImageView.adjustsImageWhenAncestorFocused = true
        titleLabel.enablesMarqueeWhenAncestorFocused = true
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        posterImageView.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.addSubview(posterImageView)
        contentView.addSubview(titleLabel)
        
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,constant: -10),
            titleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            
            posterImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            posterImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            posterImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            posterImageView.topAnchor.constraint(equalTo: contentView.topAnchor)
        ])
        
        titleLabel.text = title
        titleLabel.alpha = 0.0
    }
    
    override func didUpdateFocus(in context: UIFocusUpdateContext, with coordinator: UIFocusAnimationCoordinator) {
        coordinator.addCoordinatedAnimations({
            if self.isFocused {
                self.titleLabel.alpha = 1.0
            } else {
                self.titleLabel.alpha = 0.0
            }
        }, completion: nil)
    }
}
