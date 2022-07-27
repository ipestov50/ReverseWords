//
//  ViewController.swift
//  ReverseWords(1)
//
//  Created by Ivan Pestov on 26.07.2022.
//

import UIKit

class ViewController: UIViewController {
    
    let titleLabel = UILabel()
    let bodyLabel = UILabel()
    let textField = UITextField()
    let dividerView = UIView()
    let scrollView = UIScrollView()
    let reversedTextLabel = UILabel()
    let button = UIButton()
    
    var tapped: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        style()
        layout()
        setupNavBar()
        setupScrollView()
    }
}

extension ViewController {
    
    private func style() {
        
        // Title Label
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.font = UIFont.systemFont(ofSize: 34, weight: .bold)
        titleLabel.adjustsFontForContentSizeCategory = true // A Boolean that indicates whether the object automatically updates its font when titleLabelitleevice's content size category changes.
        titleLabel.text = "Reverse Words"
        titleLabel.textColor = .black
        
        
        // Body Label
        bodyLabel.translatesAutoresizingMaskIntoConstraints = false
        bodyLabel.font = UIFont.preferredFont(forTextStyle: .body)
        bodyLabel.text = "This application will reverse your words. Please type text below"
        bodyLabel.adjustsFontSizeToFitWidth = true
        bodyLabel.numberOfLines = 0
        bodyLabel.textColor = .systemGray
        bodyLabel.textAlignment = .center
        
        
        // Text Field
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "Text to reverse"
        textField.backgroundColor = .systemBackground
        textField.delegate = self
        
        
        // Divider View
        dividerView.translatesAutoresizingMaskIntoConstraints = false
        dividerView.backgroundColor = .separator
        
        
        // Reversed Text Label
        reversedTextLabel.translatesAutoresizingMaskIntoConstraints = false
        reversedTextLabel.font = UIFont.systemFont(ofSize: 24, weight: .light)
        reversedTextLabel.numberOfLines = 1
        reversedTextLabel.textColor = .systemBlue
        
        
        // Button
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 14
        button.setTitle("Reverse", for: .normal)
        button.titleLabel?.textColor = .white
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)

    }
    
    
    private func layout() {
        
        view.addSubview(titleLabel)
        view.addSubview(bodyLabel)
        view.addSubview(textField)
        view.addSubview(dividerView)
        view.addSubview(button)
        
        
        NSLayoutConstraint.activate([
            
            // Title Label
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 64),
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0),
            
            // Body Label
            bodyLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 16),
            bodyLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 33),
            bodyLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -34),
            
            // Text Field
            textField.topAnchor.constraint(equalTo: bodyLabel.bottomAnchor, constant: 40),
            textField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8),
            view.trailingAnchor.constraint(equalTo: textField.trailingAnchor, constant: 8),
            textField.heightAnchor.constraint(equalToConstant: 60),
            
            // Divider View
            dividerView.leadingAnchor.constraint(equalTo: textField.leadingAnchor),
            dividerView.trailingAnchor.constraint(equalTo: textField.trailingAnchor),
            dividerView.heightAnchor.constraint(equalToConstant: 1),
            dividerView.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: 0),
            
            // Button
            button.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -66),
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0),
            button.widthAnchor.constraint(equalToConstant: 343),
            button.heightAnchor.constraint(equalToConstant: 66)
        ])
    }
    
    private func setupNavBar() {
        title = "Reverse Words"
    }
    
    private func setupScrollView() {
        view.addSubview(scrollView)
        scrollView.addSubview(reversedTextLabel)
        
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        
        let contentG = scrollView.contentLayoutGuide
        let frameG = scrollView.frameLayoutGuide
        
        NSLayoutConstraint.activate([
            scrollView.bottomAnchor.constraint(equalTo: textField.bottomAnchor, constant: 40.0),
            scrollView.leadingAnchor.constraint(equalTo: textField.leadingAnchor, constant: 0),
            scrollView.trailingAnchor.constraint(equalTo: textField.trailingAnchor, constant: 0),
            scrollView.heightAnchor.constraint(equalToConstant: 30.0),
            
            reversedTextLabel.topAnchor.constraint(equalTo: contentG.topAnchor, constant: 0.0),
            reversedTextLabel.leadingAnchor.constraint(equalTo: contentG.leadingAnchor, constant: 0.0),
            reversedTextLabel.trailingAnchor.constraint(equalTo: contentG.trailingAnchor, constant: 0.0),
            reversedTextLabel.bottomAnchor.constraint(equalTo: contentG.bottomAnchor, constant: 0.0),
            
            reversedTextLabel.heightAnchor.constraint(equalTo: frameG.heightAnchor)
        
        ])
    }
    
}

extension ViewController {
    
    @objc func buttonTapped() {
        
        reversedTextLabel.text = reverseText()
        
        if tapped {
            button.setTitle("Reverse", for: .normal)
            reversedTextLabel.text = ""
        } else {
            button.setTitle("Clear", for: .normal)
            dividerView.backgroundColor = .separator
        }
        tapped.toggle()
    }
    
    func reverseText() -> String {
        let string = textField.text
        let reversed = String(string!.reversed())
        
        return reversed
    }
    
}

// MARK: - UITextFieldDelegate
extension ViewController: UITextFieldDelegate {
    
    // return NO to disallow editing.
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        return true
    }
    
    // became first responder
    func textFieldDidBeginEditing(_ textField: UITextField) {
    }
    
    // return YES to allow editing to stop and to resign first responder status.
    // return NO to disallow the editing session to end
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        dividerView.backgroundColor = .separator
        return true
    }
    
    // if implemented, called in place of textFieldDidEndEditing: ?
    func textFieldDidEndEditing(_ textField: UITextField) {
    }
    
    // detect - keypress
    // return NO to not change text
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        dividerView.backgroundColor = .systemBlue
        return true
    }
    
    // called when 'clear' button pressed. return NO to ignore (no notifications)
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        return true
    }
    
    // called when 'return' key pressed. return NO to ignore.
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.endEditing(true) // resign first responder
        return true
    }
}

