//
//  FloatingButton.swift
//  OCR Simple app
//
//  Created by Zhanibek Lukpanov on 22.08.2021.
//

import UIKit

final class FloatingButton: UIButton {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        layer.cornerRadius   = 30
        backgroundColor      = .systemGreen
        let image            = UIImage(systemName: "plus", withConfiguration: UIImage.SymbolConfiguration(pointSize: 37, weight: .semibold))
        
        tintColor            = .white
        setImage(image, for: .normal)
        
        layer.shadowRadius   = 7
        layer.shadowOpacity  = 0.3
        
        translatesAutoresizingMaskIntoConstraints = false
    }
}
