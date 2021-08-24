//
//  AlertButton.swift
//  OCR Simple app
//
//  Created by Zhanibek Lukpanov on 23.08.2021.
//

import UIKit

final class AlertButton: UIButton {

    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(backGroundColor: UIColor, title: String) {
        super.init(frame: .zero)
        self.backgroundColor = backGroundColor
        self.setTitle(title, for: .normal)
        self.setTitleColor(.white, for: .normal)
        configure()
    }
    
    private func configure() {
        layer.cornerRadius                        = 11
        titleLabel?.font                          = UIFont.preferredFont(forTextStyle: .headline)
        translatesAutoresizingMaskIntoConstraints = false
    }
    
}
