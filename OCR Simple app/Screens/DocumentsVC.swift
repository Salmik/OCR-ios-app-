//
//  ViewController.swift
//  OCR Simple app
//
//  Created by Zhanibek Lukpanov on 22.08.2021.
//

import UIKit
import WeScan

final class DocumentsVC: UIViewController {
    
    // MARK:- Properties
    var collectionView: UICollectionView!
    var floatingButton = FloatingButton(type: .system)
    
    var documents = [URL]()
    var filteredDocuments = [URL]()
    
    var documentOrderNumber = 0
        
    var scannedImage: UIImage!
    
    let searchController = UISearchController(searchResultsController: nil)
    var searchBarIsEmpty: Bool {
        guard let text = searchController.searchBar.text else { return false }
        return text.isEmpty
    }
    var isFiltered: Bool {
        return searchController.isActive && !searchBarIsEmpty
    }
    
    let emptyStateView = EmptyStateView(message: "You don't have any document!", description: "Scan or add new document by clicking the + button below and save as your required format")
    
    // MARK:- LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        configureCollectionView()
        floatingButtonConfigure()
        configureSearchController()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        documents = Utilities.getDocuments()
        collectionView.reloadData()
        
        if documents.isEmpty {
            configureEmptyStateView()
        } else {
            emptyStateView.removeFromSuperview()
        }
        
    }
    
    // MARK:- Config methods
    private func configureSearchController() {
        navigationItem.searchController                         = searchController
        navigationItem.hidesSearchBarWhenScrolling              = false
        searchController.searchResultsUpdater                   = self
        searchController.obscuresBackgroundDuringPresentation   = false
        searchController.searchBar.placeholder                  = "Search"
        searchController.searchBar.delegate                     = self
        definesPresentationContext                              = true
    }
    
    private func floatingButtonConfigure() {
        view.addSubview(floatingButton)

        NSLayoutConstraint.activate([
            floatingButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -95),
            floatingButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15),
            floatingButton.heightAnchor.constraint(equalToConstant: 60),
            floatingButton.widthAnchor.constraint(equalToConstant: 60)
        ])

        floatingButton.addTarget(self, action: #selector(floatingButtonTapped), for: .touchUpInside)
    }

    @objc private func floatingButtonTapped() {
        let actionSheet = UIAlertController(title: "Scan or Import?", message: "Choose how you want to add your file", preferredStyle: .actionSheet)
        
        actionSheet.addAction(UIAlertAction(title: "Scan", style: .default, handler: {[weak self] (_) in            
            guard let self = self else { return }
            let scannerVC = ImageScannerController()
            scannerVC.imageScannerDelegate = self
            scannerVC.modalPresentationStyle = .fullScreen
            self.present(scannerVC, animated: true, completion: nil)
            
        }))
        
        actionSheet.addAction(UIAlertAction(title: "Import", style: .default, handler: { [weak self] (_) in
            guard let self = self else {return}
            self.chooseImageSourse(.photoLibrary)
        }))
        
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        present(actionSheet, animated: true, completion: nil)
    }
    
     func configureEmptyStateView() {
        view.addSubview(emptyStateView)
        
        emptyStateView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            emptyStateView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            emptyStateView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            emptyStateView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 15),
            emptyStateView.bottomAnchor.constraint(equalTo: floatingButton.topAnchor, constant: -30)
        ])
    }

    // MARK:- configureCollectionView with DataSource
    private func configureCollectionView() {
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: UIHelper.createTwoColumFlowLayout(in: view))
        view.addSubview(collectionView)
            collectionView.backgroundColor = .systemBackground
            collectionView.register(DocumentCollectionViewCell.self, forCellWithReuseIdentifier: DocumentCollectionViewCell.reuseID)
            collectionView.delegate = self
            collectionView.dataSource = self
        }
        
    }

    // MARK:- UICollectionViewDelegate
    extension DocumentsVC: UICollectionViewDelegate {
        func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
            
            let documentExtensition = documents[indexPath.row].path.suffix(3)
            documentOrderNumber = indexPath.row
            
            var documentss = [URL]()
            
            if isFiltered {
                documentss = filteredDocuments
            } else {
                documentss = documents
            }
            
            let imageURL = documentss[documentOrderNumber]
            var documentTitle = documentss[documentOrderNumber].path.components(separatedBy: "Documents/")[1]
            documentTitle = String(Array(documentTitle)[0..<(documentTitle.count-4)])
            
            if documentExtensition == "jpg" {
                navigationController?.pushViewController(DocImageVC(doctTitle: documentTitle, imageURL: imageURL, documentNumber: documentOrderNumber), animated: true)
            }
            
            collectionView.deselectItem(at: indexPath, animated: true)
        }
    }

// MARK:- UICollectionViewDataSource
extension DocumentsVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if isFiltered {
            return filteredDocuments.count
        } else {
            return documents.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DocumentCollectionViewCell.reuseID, for: indexPath) as? DocumentCollectionViewCell else { return UICollectionViewCell() }
        
        var documentss = [URL]()
        
        if isFiltered {
            documentss = filteredDocuments
        } else {
            documentss = documents
        }
        
        let documentPath = documentss[indexPath.row].path
        let documentExtensition = documentPath.suffix(3)
        let title = documentPath.components(separatedBy: "Documents/")[1]
        
        cell.layer.cornerRadius = 9
        cell.layer.borderColor = UIColor.black.cgColor
        cell.layer.borderWidth = 0.5
        
        if documentExtensition == "jpg" {
            if let image = UIImage(contentsOfFile: documentPath) {
                let documentName = String(Array(title)[0..<(title.count-4)])
                
                cell.set(documentsName: documentName, with: image, type: "JPG")
            }
        }
        
        return cell
    }
    
}

// MARK:- UISearchBarDelegate
extension DocumentsVC: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filteredDocuments(searchText)
    }
}

//MARK: - UISearchResultsUpdating
extension DocumentsVC: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        filteredDocuments(searchController.searchBar.text!)
    }
    
    func filteredDocuments(_ searchText: String) {
        filteredDocuments = documents.filter({(document: URL)-> Bool in
            return document.absoluteString.lowercased().contains(searchText.lowercased())
        })
        collectionView.reloadData()
    }
    
}

//MARK:- ImageScannerControllerDelegate
extension DocumentsVC: ImageScannerControllerDelegate {
    
    func imageScannerController(_ scanner: ImageScannerController, didFinishScanningWithResults results: ImageScannerResults) {
        
        if results.doesUserPreferEnhancedScan {
            scannedImage = results.enhancedScan?.image
        } else {
            scannedImage = results.croppedScan.image
        }
        scanner.dismiss(animated: true, completion: nil)
        showSaveDialog(scannedImage: scannedImage)
    }
    func imageScannerControllerDidCancel(_ scanner: ImageScannerController) {
        scanner.dismiss(animated: true, completion: nil)
    }
    
    func imageScannerController(_ scanner: ImageScannerController, didFailWithError error: Error) {
        print(error.localizedDescription)
    }
    
}
