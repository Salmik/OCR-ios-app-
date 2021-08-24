//
//  BodyLabel.swift
//  OCR Simple app
//
//  Created by Zhanibek Lukpanov on 22.08.2021.
//

import UIKit

final class BodyLabel: UILabel {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(textAligment: NSTextAlignment) {
        super.init(frame: .zero)
        self.textAlignment = textAligment
        configure()
    }
    
    private func configure() {
        textColor                                 = .secondaryLabel
        font                                      = UIFont.systemFont(ofSize: 17, weight: .light)
        adjustsFontSizeToFitWidth                 = true
        minimumScaleFactor                        = 0.75
        lineBreakMode                             = .byWordWrapping
        numberOfLines                             = 0
        translatesAutoresizingMaskIntoConstraints = false
    }

}
