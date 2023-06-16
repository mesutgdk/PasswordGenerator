//
//  ViewController.swift
//  Password
//
//  Created by Mesut Gedik on 14.06.2023.
//

import UIKit

class ViewController: UIViewController {
    
    let stackView = UIStackView()
    let passwordStatusView = PasswordStatusView()
    let passwordTextField = PasswordTextField(placeHolderText:"New Password",errorLabelIsHidden: true)
    let passwordTextField2 = PasswordTextField(placeHolderText: "New View",errorLabelIsHidden: true)
    let button = UIButton(type: .system)

    
    var password : String? {
        return passwordTextField.passwordTextField.text
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        style()
        layout()
    }
}
extension ViewController {
    private func style(){
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 20
        
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        passwordTextField2.translatesAutoresizingMaskIntoConstraints = false
        passwordTextField.delegate = self

        passwordStatusView.translatesAutoresizingMaskIntoConstraints = false
    
        button.translatesAutoresizingMaskIntoConstraints = false
        button.configuration = .filled()
        button.configuration?.imagePadding = 8 // for indicator spacing
        button.setTitle("Reset Password", for: [])
        button.addTarget(self, action: #selector(resetPasswordButtonTapped), for: .primaryActionTriggered)
    }
    
    private func layout() {
//
        stackView.addArrangedSubview(passwordTextField)
        stackView.addArrangedSubview(passwordStatusView)
        stackView.addArrangedSubview(passwordTextField2)
        stackView.addArrangedSubview(button)
        view.addSubview(stackView)
        
//        StackView
        NSLayoutConstraint.activate([
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            stackView.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 2),
            view.trailingAnchor.constraint(equalToSystemSpacingAfter: stackView.trailingAnchor, multiplier: 2)

        ])
    }
}
//Actions
extension ViewController {
    @objc func resetPasswordButtonTapped(){
    
    }
}

// MARK: - PasswordTextFieldDegate
extension ViewController: PasswordTextFieldDelegate {
    func editingChanged(_ sender: PasswordTextField) {
        if sender === passwordTextField {
            
        }
    }
    
    
}


