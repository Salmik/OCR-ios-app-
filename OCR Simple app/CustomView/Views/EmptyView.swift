//
//  EmptyView.swift
//  OCR Simple app
//
//  Created by Zhanibek Lukpanov on 22.08.2021.
//

import UIKit

class EmptyStateView: UIView {
    
    let messageLabel      = Titlelabel(textAligment: .center, fontSize: 22)
    let descriptionLabel  = BodyLabel(textAligment: .center)
    let logoImageView     = UIImageView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(message: String, description: String) {
        super.init(frame: .zero)
        messageLabel.text = message
        descriptionLabel.text = description
        configure()
    }
    
    private func configure() {
        addSubview(messageLabel)
        addSubview(logoImageView)
        addSubview(descriptionLabel)
        
        messageLabel.numberOfLines  = 3
        messageLabel.textColor      = .secondaryLabel
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        
        descriptionLabel.numberOfLines  = 7
        descriptionLabel.textColor      = .secondaryLabel
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        
        guard let image = UIImage(systemName: "folder.badge.plus")?.withTintColor(#colorLiteral(red: 0.5410659909, green: 0.5409145951, blue: 0.5574275851, alpha: 1), renderingMode: .alwaysOriginal) else { return }
       
        logoImageView.image             = image
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            
            logoImageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 30),
            logoImageView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            logoImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 30),
            logoImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -30),
            logoImageView.heightAnchor.constraint(equalToConstant: 250),
            
            messageLabel.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 25),
            messageLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            messageLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            messageLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
            
            descriptionLabel.topAnchor.constraint(equalTo: messageLabel.bottomAnchor, constant: 25),
            descriptionLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            descriptionLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            descriptionLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10)
        ])
    }
}
