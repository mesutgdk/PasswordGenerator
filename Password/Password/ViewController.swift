//
//  ViewController.swift
//  Password
//
//  Created by Mesut Gedik on 14.06.2023.
//

import UIKit

class ViewController: UIViewController {
    
    let passwordTextView = PasswordTextView(placeHolderText:"New Password")
    
    var password : String? {
        return passwordTextView.passwordTextField.text
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        style()
        layout()
    }
}
extension ViewController {
    private func style(){
        passwordTextView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func layout() {
        view.addSubview(passwordTextView)
        
        NSLayoutConstraint.activate([
            passwordTextView.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 2),
            view.trailingAnchor.constraint(equalToSystemSpacingAfter: passwordTextView.trailingAnchor, multiplier: 2),
            view.centerYAnchor.constraint(equalToSystemSpacingBelow: passwordTextView.centerYAnchor, multiplier: 2)
//            passwordView2.topAnchor.constraint(equalToSystemSpacingBelow: view.safeAreaLayoutGuide.topAnchor, multiplier: 2)
        ])
    }
    
}

