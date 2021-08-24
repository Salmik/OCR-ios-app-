//
//  GFAlertVC.swift
//  GHFollowers
//
//  Created by Zhanibek Lukpanov on 17.08.2021.
//

import UIKit

final class AlertCustom: UIViewController {
    
   private let container    = UIView()
   private let titleLabel   = Titlelabel(textAligment: .center, fontSize: 20)
   private let bodyLabel    = BodyLabel(textAligment: .center)
   private let actionButton = AlertButton(backGroundColor: .systemBlue, title: "OK")

    var alertTitle: String?
    var message: String?
    var buttonTitle: String?
    
    let padding: CGFloat = 20
    
    init(title: String, message: String, buttonTitle: String) {
        super.init(nibName: nil, bundle: nil)
        self.alertTitle   = title
        self.message      = message
        self.buttonTitle  = buttonTitle
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.75)
        configureContainerView()
        configureTitleLabel()
        configureActionButton()
        configureBodyLabel()
    }
    
    func configureContainerView() {
        view.addSubview(container)
        container.backgroundColor                           = .systemBackground
        container.layer.cornerRadius                        = 16
        container.layer.borderWidth                         = 3
        container.layer.borderColor                         = UIColor.white.cgColor
        container.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            container.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            container.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            container.heightAnchor.constraint(equalToConstant: 210),
            container.widthAnchor.constraint(equalToConstant: 290)
        ])
    }
    
    func configureTitleLabel() {
        container.addSubview(titleLabel)
        titleLabel.text = alertTitle ?? "Something wrong"
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: container.topAnchor, constant: padding),
            titleLabel.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: padding),
            titleLabel.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -padding),
            titleLabel.heightAnchor.constraint(equalToConstant: 29)
        ])
    }
    
    func configureActionButton() {
        container.addSubview(actionButton)
        actionButton.setTitle(buttonTitle ?? "OK", for: .normal)
        actionButton.addTarget(self, action: #selector(dissmissVC), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            actionButton.bottomAnchor.constraint(equalTo: container.bottomAnchor, constant: -padding),
            actionButton.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: padding),
            actionButton.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -padding),
            actionButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    @objc func dissmissVC() {
        dismiss(animated: true, completion: nil)
    }
    
    func configureBodyLabel() {
        container.addSubview(bodyLabel)
        bodyLabel.text            = message ?? "Unable to complete request"
        bodyLabel.numberOfLines   = 5
        
        NSLayoutConstraint.activate([
            bodyLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 7),
            bodyLabel.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: padding),
            bodyLabel.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -padding),
            bodyLabel.bottomAnchor.constraint(equalTo: actionButton.topAnchor, constant: -11)
        ])
    }

    deinit {
        print("Deinit\(self)")
    }
}
