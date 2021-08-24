//
//  DocumentsVC + ImagePicker.swift
//  OCR Simple app
//
//  Created by Zhanibek Lukpanov on 22.08.2021.
//

import UIKit

//MARK:- UIImagePickerControllerDelegate
extension DocumentsVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func chooseImageSourse(_ source: UIImagePickerController.SourceType) {

        if UIImagePickerController.isSourceTypeAvailable(source) {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.allowsEditing = true
            imagePicker.sourceType = source
            present(imagePicker, animated: true, completion: nil)
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        DispatchQueue.main.async { [weak self] in
          guard let self = self else {return}
          guard let image = info[.editedImage] as? UIImage else { return print("OOPSSS")}
            self.showSaveDialog(scannedImage: image)
        }

        dismiss(animated: true, completion: nil)
    }
    
}
