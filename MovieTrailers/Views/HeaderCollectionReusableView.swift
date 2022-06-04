//
//  HeaderCollectionReusableView.swift
//  MovieTrailers
//
//  Created by Oğuzhan Varsak on 5.06.2022.
//

import UIKit

class HeaderCollectionReusableView: UICollectionReusableView {
    let titleLabel = UILabel()
    
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
    
    func configure() {
        titleLabel.enablesMarqueeWhenAncestorFocused = true
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(titleLabel)
        
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor,constant: -10),
            titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10)
        ])
        
        titleLabel.text = title
    }
}
