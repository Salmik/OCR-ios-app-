//
//  Titlelabel.swift
//  OCR Simple app
//
//  Created by Zhanibek Lukpanov on 22.08.2021.
//

import UIKit

final class Titlelabel: UILabel {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(textAligment: NSTextAlignment, fontSize: CGFloat) {
        super.init(frame: .zero)
        self.textAlignment = textAligment
        self.font = UIFont.systemFont(ofSize: fontSize, weight: .bold)
        configure()
    }
    
    private func configure() {
        textColor                                 = .label
        adjustsFontSizeToFitWidth                 = true
        minimumScaleFactor                        = 0.9
        lineBreakMode                             = .byTruncatingTail
        translatesAutoresizingMaskIntoConstraints = false
        numberOfLines                             = 0
    }
    
}
