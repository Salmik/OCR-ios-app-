//
//  UIViewController +  extension.swift
//  OCR Simple app
//
//  Created by Zhanibek Lukpanov on 23.08.2021.
//

import UIKit

extension UIViewController {
    // Custom Alert
    func presentCustomAlertOnMainThread(title: String, message: String, buttonTitle: String) {
        DispatchQueue.main.async {[weak self] in
            
            guard let self = self else { return }
            
            let alertVC = AlertCustom(title: title, message: message, buttonTitle: buttonTitle)
            alertVC.modalPresentationStyle  = .overFullScreen
            alertVC.modalTransitionStyle    = .crossDissolve
            self.present(alertVC, animated: true, completion: nil)
        }
    
}
}
