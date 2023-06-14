//
//  ViewController.swift
//  Password
//
//  Created by Mesut Gedik on 14.06.2023.
//

import UIKit

class ViewController: UIViewController {
    
    let passwordView = PasswordView()
    
    var password : String? {
        return passwordView.passwordtextField.text
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        style()
        layout()
    }
}
extension ViewController {
    private func style(){
        passwordView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func layout() {
        view.addSubview(passwordView)
        
        NSLayoutConstraint.activate([
            passwordView.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 2),
            view.trailingAnchor.constraint(equalToSystemSpacingAfter: passwordView.trailingAnchor, multiplier: 2),
//            view.topAnchor.constraint(equalToSystemSpacingBelow: passwordView.topAnchor, multiplier: 2)
            passwordView.topAnchor.constraint(equalToSystemSpacingBelow: view.safeAreaLayoutGuide.topAnchor, multiplier: 2)
        ])
    }
    
}

