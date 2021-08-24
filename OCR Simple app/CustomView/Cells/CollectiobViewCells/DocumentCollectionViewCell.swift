//
//  DocumentCollectionViewCell.swift
//  OCR Simple app
//
//  Created by Zhanibek Lukpanov on 22.08.2021.
//

import UIKit
 
final class DocumentCollectionViewCell: UICollectionViewCell {
    
    static let reuseID = "DocumentCollectionViewCell"
    
    private var imageView = UIImageView()
    private var titleLabel = UILabel()
    private var documetsType = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        contentView.addSubview(imageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(documetsType)
        
        imageView.translatesAutoresizingMaskIntoConstraints     = false
        titleLabel.translatesAutoresizingMaskIntoConstraints    = false
        documetsType.translatesAutoresizingMaskIntoConstraints  = false
        
        let padding: CGFloat = 7
        
        NSLayoutConstraint.activate([
            // imageView constraints
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: padding),
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
            imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor),
            
            // titleLabel constraints
            titleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 11),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            titleLabel.trailingAnchor.constraint(equalTo: documetsType.leadingAnchor, constant: -padding),
            titleLabel.heightAnchor.constraint(equalToConstant: 20),
            
            // documetsType constraints
            documetsType.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 11),
            documetsType.leadingAnchor.constraint(equalTo: titleLabel.trailingAnchor, constant: padding),
            documetsType.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
            documetsType.heightAnchor.constraint(equalToConstant: 20)
        ])
        
    }
    
    func set(documentsName: String, with image: UIImage, type: String) {
        self.titleLabel.text = documentsName
        self.imageView.image = image
        self.documetsType.text = type
    }
    
}
