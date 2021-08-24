//
//  DocImageVC + extension.swift
//  OCR Simple app
//
//  Created by Zhanibek Lukpanov on 22.08.2021.
//

import UIKit

extension DocImageVC {
    //share Document
    func shareDocument(documentPath: String) {
        
        if FileManager.default.fileExists(atPath: documentPath){
            let fileURL = URL(fileURLWithPath: documentPath)
            let activityViewController: UIActivityViewController = UIActivityViewController(activityItems: [fileURL], applicationActivities: nil)
            activityViewController.popoverPresentationController?.sourceView = self.view
            present(activityViewController, animated: true, completion: nil)
        }
        else {
            print("Document was not found")
        }
    }
    
    //usual AlertView
    func showAlertWith(title: String, message: String){
        
        let ac = UIAlertController(title: title, message: message, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default, handler: { [weak self] (UIAlertAction) in
            guard let self = self else {return}
            if let firstViewController = self.navigationController?.viewControllers.first {
                self.navigationController?.popToViewController(firstViewController, animated: true)
            }
        }))
        DispatchQueue.main.async {[weak self] in
            guard let self = self else {return}
            self.present(ac, animated: true)
        }
    }
    
}
