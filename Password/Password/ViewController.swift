//
//  ViewController.swift
//  Password
//
//  Created by Mesut Gedik on 14.06.2023.
//

import UIKit

class ViewController: UIViewController {
    typealias CustomValidation = PasswordTextField.CustomValidation
    
    let stackView = UIStackView()
    let passwordStatusView = PasswordStatusView()
    let passwordTextField = PasswordTextField(placeHolderText:"New Password")
    let passwordTextField2 = PasswordTextField(placeHolderText: "New View")
    let button = UIButton(type: .system)

    
    var password : String? {
        return passwordTextField.passwordTextField.text
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        style()
        layout()
        setup() // recognizeTapGester
    }
}
extension ViewController {
    // MARK: TapGestureRecognizer - Ekrana dokunulduğunda editing'i durdurur
    private func setup(){
        setupDissmissKeyboardgesture()
        setupNewPassword()
    }
    private func setupDissmissKeyboardgesture() {
        let dismissKeyboardTap = UITapGestureRecognizer(target: self, action: #selector(viewTapped(_: )))
        view.addGestureRecognizer(dismissKeyboardTap)
    }
    @objc func viewTapped (_ recognizer: UITapGestureRecognizer){
        view.endEditing(true)   // resign first responder
    }
    private func setupNewPassword() {
        let newPasswordValidation: CustomValidation = { text in
            
            //Empty text
            guard let text = text, !text.isEmpty else {
                self.passwordStatusView.reset()
                return (false, "Enter your Password")
            }
            
            // Valid characters
            let validChars = "abcçdefgğhıijklmnoöprsştuüvwxyzABCÇDEFGĞHIİJKLMNOÖPRSŞTUÜVWXYZ1234567890.,:;@!+-&/?#$₺()"
            let invalidSet = CharacterSet(charactersIn: validChars).inverted
            guard text.rangeOfCharacter(from: invalidSet) == nil else {
                self.passwordStatusView.reset()
                return (false, "Enter valid special chars .,:;@!+-&/?#$₺() with no spaces")
            }
            
            return (true, "")
        }
        passwordTextField.customValidation = newPasswordValidation
    }
    
    
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
            passwordStatusView.updateDisplay(sender.passwordTextField.text ?? "")
        }
    }
    func editingDidEnd(_ sender: PasswordTextField) {
//        print("foo- \(sender.passwordTextField.text)")
        if sender === passwordTextField {
            _ = passwordTextField.validate()
        }
    }
    
}


