//
//  ViewController.swift
//  Password
//
//  Created by Mesut Gedik on 14.06.2023.
//

import UIKit

class ViewController: UIViewController {
    
    let stackView = UIStackView()
    
    let passwordTextView = PasswordTextView(placeHolderText:"New Password",errorLabelIsHidden: false)
    
    let passwordTextView2 = PasswordTextView(placeHolderText: "New View",errorLabelIsHidden: true)
    
    let statusView1 = StatusView(checkImage: UIImage(systemName: "eye.circle")!.withTintColor(.tertiaryLabel,renderingMode: .alwaysOriginal), statusLabelText: "upper letter (A-Z)")
    let statusView2 = StatusView(checkImage: UIImage(systemName: "eye.circle")!, statusLabelText: "222")
    
    let button = UIButton(type: .system)
    
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
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 20
        
        
        passwordTextView.translatesAutoresizingMaskIntoConstraints = false
        passwordTextView2.translatesAutoresizingMaskIntoConstraints = false
        
        statusView1.translatesAutoresizingMaskIntoConstraints = false
        statusView2.translatesAutoresizingMaskIntoConstraints = false

        
        button.translatesAutoresizingMaskIntoConstraints = false
        button.configuration = .filled()
        button.configuration?.imagePadding = 8 // for indicator spacing
        button.setTitle("Reset Password", for: [])
        button.addTarget(self, action: #selector(resetPassword), for: .primaryActionTriggered)
    }
    
    private func layout() {
      
        stackView.addArrangedSubview(passwordTextView)
        stackView.addArrangedSubview(statusView1)
        stackView.addArrangedSubview(statusView2)
        stackView.addArrangedSubview(passwordTextView2)
        stackView.addArrangedSubview(button)
        view.addSubview(stackView)
        
        //StackView
        NSLayoutConstraint.activate([
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            stackView.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 2),
            view.trailingAnchor.constraint(equalToSystemSpacingAfter: stackView.trailingAnchor, multiplier: 2)
            
        ])
    }
}
//Actions
extension ViewController {
    @objc func resetPassword(){
        
    }
}

