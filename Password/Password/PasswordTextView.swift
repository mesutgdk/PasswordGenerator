//
//  PasswordView2.swift
//  Password
//
//  Created by Mesut Gedik on 14.06.2023.
//

import Foundation
import Foundation
import UIKit

class PasswordTextView: UIView {
    
    let passwordTextField = UITextField()
    let dividerView = UIView()
    let errorLabel = UILabel()
    let padlockImageView = UIImageView(image: UIImage(systemName: "lock.fill"))
    let eyeButton = UIButton(type: .custom)
    
    let placeHolderText: String
    
    init(placeHolderText: String) {
        self.placeHolderText = placeHolderText
        
        super.init(frame: .zero)
        
        style()
        layout()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override var intrinsicContentSize: CGSize {
        return CGSize(width: 200, height: 60)
    }
}
extension PasswordTextView {
    func style(){
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .systemOrange
        
        padlockImageView.translatesAutoresizingMaskIntoConstraints = false
        
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        passwordTextField.placeholder = placeHolderText
        passwordTextField.isSecureTextEntry = false
        passwordTextField.delegate = self
        passwordTextField.keyboardType = .asciiCapable
        passwordTextField.attributedPlaceholder = NSAttributedString(string: placeHolderText, attributes: [NSAttributedString.Key.foregroundColor:UIColor.secondaryLabel])
        
        eyeButton.translatesAutoresizingMaskIntoConstraints = false
        eyeButton.setImage(UIImage(systemName: "eye.circle"), for: .normal)
        eyeButton.setImage(UIImage(systemName: "eye.slash.circle"), for: .selected)
        eyeButton.addTarget(self, action: #selector(togglePasswordView), for: .touchUpInside)
        
        dividerView.translatesAutoresizingMaskIntoConstraints = false
        dividerView.backgroundColor = .secondarySystemFill
        
        errorLabel.translatesAutoresizingMaskIntoConstraints = false
        errorLabel.textAlignment = .left
        errorLabel.textColor = .systemRed
        errorLabel.numberOfLines = 0
        errorLabel.text = "Enter your password"
        
        
        layer.cornerRadius = 5
        clipsToBounds = true
    }
    func layout() {
        addSubview(padlockImageView)
        addSubview(passwordTextField)
        addSubview(eyeButton)
        addSubview(dividerView)
        addSubview(errorLabel)
        
        //Padlock
        NSLayoutConstraint.activate([
            padlockImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            padlockImageView.centerYAnchor.constraint(equalTo: passwordTextField.centerYAnchor)
        ])
        //TextField
        NSLayoutConstraint.activate([
            passwordTextField.leadingAnchor.constraint(equalToSystemSpacingAfter: padlockImageView.trailingAnchor, multiplier: 1),
            passwordTextField.topAnchor.constraint(equalTo: topAnchor),
           
        ])
        //PasswordToggleButton
        NSLayoutConstraint.activate([
            eyeButton.leadingAnchor.constraint(equalToSystemSpacingAfter: passwordTextField.trailingAnchor, multiplier: 1),
            eyeButton.centerYAnchor.constraint(equalTo: passwordTextField.centerYAnchor),
            eyeButton.trailingAnchor.constraint(equalTo: trailingAnchor)
//            trailingAnchor.constraint(equalTo: eyeButton.trailingAnchor)
        ])
        //DividerView
        NSLayoutConstraint.activate([
            dividerView.leadingAnchor.constraint(equalTo: leadingAnchor),
            dividerView.topAnchor.constraint(equalToSystemSpacingBelow: passwordTextField.bottomAnchor, multiplier: 1),
            trailingAnchor.constraint(equalTo: dividerView.trailingAnchor),
            dividerView.heightAnchor.constraint(equalToConstant: 1)
        ])
        //ErrorLabel
        NSLayoutConstraint.activate([
            errorLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            errorLabel.topAnchor.constraint(equalTo: dividerView.bottomAnchor, constant: 4),
            errorLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            errorLabel.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
        
        //CHCR
        padlockImageView.setContentHuggingPriority(UILayoutPriority.defaultHigh, for: .horizontal)
        passwordTextField.setContentHuggingPriority(UILayoutPriority.defaultLow, for: .horizontal)
        eyeButton.setContentHuggingPriority(UILayoutPriority.defaultHigh, for: .horizontal)
    }
}
// MARK: - UITextFieldDelegate
extension PasswordTextView: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        passwordTextField.endEditing(true)
        return true
    }
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        return true
        
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        
    }
}
//Actions
extension PasswordTextView {
    
    @objc func togglePasswordView(_sender: Any){
        passwordTextField.isSecureTextEntry.toggle()
        eyeButton.isSelected.toggle()
    }
}



