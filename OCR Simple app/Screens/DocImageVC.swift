//
//  DocImageVC.swift
//  OCR Simple app
//
//  Created by Zhanibek Lukpanov on 22.08.2021.
//

import UIKit

final class DocImageVC: UIViewController {

    // MARK:- Properties
    private var detailImageView = ImageScrollView(frame: .zero)
    private var scrollView = UIScrollView()
    
    var pictureOrderNumber = 0
    
    var doctTitle: String?
    var imageURL: URL!
    
    private var documents = [URL]()
    
    // MARK:- LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        title = doctTitle
        view.backgroundColor = .systemBackground
        configureVC()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        scrollView.frame = view.bounds
    }
    
    init(doctTitle: String, imageURL: URL, documentNumber: Int) {
        super.init(nibName: nil, bundle: nil)
        self.doctTitle = doctTitle
        self.imageURL = imageURL
        self.pictureOrderNumber = documentNumber
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK:- Config methods
    private func configureVC() {
        
        let button1 = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(self.exportButtonTapped))
        self.navigationItem.rightBarButtonItem = button1
        navigationItem.largeTitleDisplayMode = .never
        
        view.addSubview(scrollView)
        scrollView.minimumZoomScale = 1.0
        scrollView.maximumZoomScale = 10.0
        
        documents = Utilities.getDocuments()
        
        detailImageView = ImageScrollView(frame: view.bounds)
        detailImageView.contentMode = .scaleAspectFit
        
        guard let image = UIImage(contentsOfFile: imageURL.path) else { return }
        
        detailImageView.set(image: image)
        
        view.addSubview(detailImageView)
    }
    
    @objc private func exportButtonTapped() {
        
        let actionSheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { action in
            //            self.dismiss(animated: true) {}
        }))
        
        actionSheet.addAction(UIAlertAction(title: "Share", style: .default, handler: {[weak self] action in
            //            self.dismiss(animated: true) {}
            DispatchQueue.main.async {
                guard let self = self else {return}
                self.shareDocument(documentPath: self.documents[self.pictureOrderNumber].path)
            }
        }))
        
        actionSheet.addAction(UIAlertAction(title: "OCR", style: .default, handler: { [weak self] (action) in
            guard let self = self else { return }
            
            OCRManager.shared.recognizeText(in: self.detailImageView.imageZoomView.image!)
            OCRManager.shared.completion = {[weak self] text in
                guard let self = self else { return }
                DispatchQueue.main.async {
                    self.navigationController?.pushViewController(TextEditingVC(ocr: text), animated: true)
                }
            }
        }))
        
        actionSheet.addAction(UIAlertAction(title: "Export to Photo Album", style: .default, handler: { [weak self] action in
            guard let self = self else {return}
            if let image = UIImage(contentsOfFile: self.documents[self.pictureOrderNumber].path) {
                MyAwesomeAlbum.shared.save(image: image)
                self.showAlertWith(title: "Saved!", message: "Your image has been saved to your Photo Album.")
            }
            //            self.dismiss(animated: true) {
            //            }
        }))
        
        actionSheet.addAction(UIAlertAction(title: "Delete", style: .destructive, handler: {[weak self] _ in
            guard let self = self else {return}
            do {
                let filePath = self.documents[self.pictureOrderNumber]
                try FileManager.default.removeItem(at: filePath)
                
                if let firstViewController = self.navigationController?.viewControllers.first {
                    self.navigationController?.popToViewController(firstViewController, animated: true)
                }
            } catch {
                print("Delete error")
            }
        }))
        
        present(actionSheet, animated: true)
    }
    
}
