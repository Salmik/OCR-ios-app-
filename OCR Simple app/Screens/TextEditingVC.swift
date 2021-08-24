//
//  TextEditingVC.swift
//  OCR Simple app
//
//  Created by Zhanibek Lukpanov on 22.08.2021.
//

import UIKit

final class TextEditingVC: UIViewController {
    
    // MARK:- Properties
    var OCRResult = ""
    
    private let textView: UITextView = {
       let textView = UITextView()
        textView.backgroundColor = .white
        textView.textColor = .label
        textView.returnKeyType = .done
        textView.autocorrectionType = .yes
        textView.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        textView.contentInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        textView.layer.cornerRadius = 15
        return textView
    }()
    
    var bottomOcrConstraint: NSLayoutConstraint!

    // MARK:- LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureVC()
        configureKeyBoardDoneButton()
        configureKeyboardLayout()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    init(ocr text: String) {
        super.init(nibName: nil, bundle: nil)
        self.OCRResult = text
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        textView.resignFirstResponder()
    }
    
    // MARK:- Config methods
    private func configureVC() {
        
        let button1 = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(self.actionButtonTapped))
        self.navigationItem.rightBarButtonItem = button1
        navigationItem.largeTitleDisplayMode = .never
        
        title = "OCR Result edit"
        view.backgroundColor = #colorLiteral(red: 0.9215686275, green: 0.9215686275, blue: 0.9254901961, alpha: 1)
        
        view.addSubview(textView)
        textView.text = OCRResult
        
        textView.translatesAutoresizingMaskIntoConstraints = false
        
        bottomOcrConstraint = textView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        
        NSLayoutConstraint.activate([
            textView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            textView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            textView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            textView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -110)
        ])
    }
    
    // Addind done button to hide keyboard
    private func configureKeyBoardDoneButton() {
        let toolBar = UIToolbar(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 50))
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        let doneButton = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(doneButtonTapped))
        
        toolBar.items = [flexibleSpace,doneButton]
        toolBar.sizeToFit()
        textView.inputAccessoryView = toolBar
    }
    
    @objc private func doneButtonTapped() {
        textView.resignFirstResponder()
    }
    
    // configure
    private func configureKeyboardLayout() {
        NotificationCenter.default.addObserver(self, selector: #selector(updateTextView(notification:)), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(updateTextView(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func updateTextView(notification: Notification) {
        
        guard let userinfo = notification.userInfo as? [String:AnyObject],
              let keyboardFrame = (userinfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else { return }
        
        if notification.name == UIResponder.keyboardWillHideNotification {
            textView.contentInset = UIEdgeInsets.zero
        } else {
            textView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardFrame.height - bottomOcrConstraint.constant, right: 0)
            textView.scrollIndicatorInsets = textView.contentInset
        }
        
        textView.scrollRangeToVisible(textView.selectedRange)
        
    }
    
    @objc private func actionButtonTapped() {
        let alert = UIAlertController(title: "Choose action's", message: "Type what actions you want to do", preferredStyle: .actionSheet)
        
        alert.addAction(UIAlertAction(title: "Copy", style: .default, handler: { [weak self] (_) in
            guard let self = self else { return }
            let text = self.textView.text
            let paste = UIPasteboard.general
            paste.string = text
            
            self.presentCustomAlertOnMainThread(title: "Copied", message: "Your text was successfully copied", buttonTitle: "OK")
        }))
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        present(alert, animated: true, completion: nil)
    }
    
}
