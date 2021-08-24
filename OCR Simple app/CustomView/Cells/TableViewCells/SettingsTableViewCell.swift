//
//  SettingsTableViewCell.swift
//  OCR Simple app
//
//  Created by Zhanibek Lukpanov on 22.08.2021.
//

import UIKit

class SettingsTableViewCell: UITableViewCell {

   static let reuseID = "SettingsTableViewCell"
    
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
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(label)
        contentView.addSubview(iconContainer)
        iconContainer.addSubview(iconmageView)
        contentView.clipsToBounds = true
        accessoryType = .disclosureIndicator
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
        
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        iconmageView.image = nil
        label.text = nil
        iconContainer.backgroundColor = nil
    }
    
    public func configure(model: SettingsOption) {
        label.text = model.title
        iconmageView.image = model.icon
        iconContainer.backgroundColor = model.iconBackgorundColor
    }
    
}
