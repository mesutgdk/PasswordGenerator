//
//  PasswordView.swift
//  Password
//
//  Created by Mesut Gedik on 14.06.2023.
//

import Foundation
import UIKit

class PasswordView: UIView {
    
    let stackView = UIStackView()
    
    let passwordtextField = UITextField()
    let dividerView = UIView()
    let errorLabel = UILabel()
    

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        style()
        layout()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
extension PasswordView {
    func style(){
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .secondarySystemBackground
       
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 8
        
        passwordtextField.translatesAutoresizingMaskIntoConstraints = false
        passwordtextField.placeholder = "New Password"
        passwordtextField.isSecureTextEntry = true
        passwordtextField.delegate = self
        passwordtextField.enablePasswordToggle()
        passwordtextField.enablePadlock()
        
        dividerView.translatesAutoresizingMaskIntoConstraints = false
        dividerView.backgroundColor = .secondarySystemFill
        
        
        errorLabel.translatesAutoresizingMaskIntoConstraints = false
        errorLabel.textAlignment = .left
        errorLabel.textColor = .systemRed
        errorLabel.numberOfLines = 0
        errorLabel.text = "Enter your password"
//        errorLabel.isHidden = true
        
        
        layer.cornerRadius = 5
        clipsToBounds = true
    }
    func layout() {
        stackView.addArrangedSubview(passwordtextField)
        stackView.addArrangedSubview(dividerView)
        stackView.addArrangedSubview(errorLabel)
        
        addSubview(stackView)
        
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalToSystemSpacingBelow: topAnchor, multiplier: 1),
            stackView.leadingAnchor.constraint(equalToSystemSpacingAfter: leadingAnchor, multiplier: 1),
            trailingAnchor.constraint(equalToSystemSpacingAfter: stackView.trailingAnchor, multiplier: 1),
            bottomAnchor.constraint(equalToSystemSpacingBelow: stackView.bottomAnchor, multiplier: 1)
        ])
        
        dividerView.heightAnchor.constraint(equalToConstant: 1).isActive = true
    }
}
// MARK: - UITextFieldDelegate
extension PasswordView: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        passwordtextField.endEditing(true)
        return true
    }
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        return true
        
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        
    }
}

let passwordToggleButton = UIButton(type: .custom)
let padlockImage = UIImageView()

extension UITextField {
    func enablePadlock(){
        padlockImage.image = UIImage(systemName: "lock.fill", withConfiguration: UIImage.SymbolConfiguration(font: .systemFont(ofSize: 18)))
        
        leftView = padlockImage
        leftViewMode = .always
    }
    
    func enablePasswordToggle(){
        passwordToggleButton.setImage(UIImage(systemName: "eye.fill"), for: .normal)
        passwordToggleButton.setImage(UIImage(systemName: "eye.slash.fill"), for: .selected)
        
        passwordToggleButton.addTarget(self, action: #selector(togglePasswordView), for: .touchUpInside)
        rightView = passwordToggleButton
        rightViewMode = .always
    }
    
    @objc func togglePasswordView(_sender: Any){
        isSecureTextEntry.toggle()
        passwordToggleButton.isSelected.toggle()
    }
}

