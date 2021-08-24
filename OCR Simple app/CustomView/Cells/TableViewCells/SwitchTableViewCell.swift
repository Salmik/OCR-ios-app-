//
//  SwitchTableViewCell.swift
//  OCR Simple app
//
//  Created by Zhanibek Lukpanov on 22.08.2021.
//

import UIKit

class SwitchTableViewCell: UITableViewCell {

    static let reuseID = "SwitchTableViewCell"
     
     private let iconContainer: UIView = {
        let iconContainer = UIView()
         iconContainer.clipsToBounds = true
         iconContainer.layer.masksToBounds = true
         iconContainer.layer.cornerRadius = 11
         return iconContainer
     }()
     
     private let iconmageView: UIImageView = {
        let imageVIew = UIImageView()
         imageVIew.tintColor = .white
         imageVIew.contentMode = .scaleAspectFit
         return imageVIew
     }()
     
     private let label: UILabel = {
        let label = UILabel()
         label.numberOfLines = 1
         return label
     }()
    
    private let switcher: UISwitch = {
        let switcher = UISwitch()
        switcher.onTintColor = .systemGreen
        switcher.translatesAutoresizingMaskIntoConstraints = false
        return switcher
    }()
     
     override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
         super.init(style: style, reuseIdentifier: reuseIdentifier)
         contentView.addSubview(label)
         contentView.addSubview(iconContainer)
         contentView.addSubview(switcher)
         iconContainer.addSubview(iconmageView)
         contentView.clipsToBounds = true
     }
     
     required init?(coder: NSCoder) {
         fatalError("init(coder:) has not been implemented")
     }
     
     override func layoutSubviews() {
         super.layoutSubviews()
         
         let size = contentView.frame.size.height - 12
         iconContainer.frame = CGRect(x: 10, y: 6, width: size, height: size)
         
         let imageSize = size/1.5
         iconmageView.frame = CGRect(x: (size-imageSize)/2, y: (size-imageSize)/2, width: imageSize, height: imageSize)
         
         label.frame = CGRect(x: 21+iconContainer.frame.size.width,
                              y: 0,
                              width: contentView.frame.size.width-21-iconContainer.frame.size.width-10,
                              height: contentView.frame.size.height)
        
        NSLayoutConstraint.activate([
//            switcher.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 3),
            switcher.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5),
            switcher.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            switcher.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5)
        ])
         
     }
     
     override func prepareForReuse() {
         super.prepareForReuse()
         iconmageView.image = nil
         label.text = nil
         iconContainer.backgroundColor = nil
     }
     
     public func configure(model: SettingsSwitchOption) {
         label.text = model.title
         iconmageView.image = model.icon
         iconContainer.backgroundColor = model.iconBackgorundColor
         switcher.isOn = model.isOn
     }

}

