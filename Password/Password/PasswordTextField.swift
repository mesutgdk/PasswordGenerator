//
//  PasswordView2.swift
//  Password
//
//  Created by Mesut Gedik on 14.06.2023.
//

import Foundation
import UIKit

protocol PasswordTextFieldDelegate: AnyObject {
    func editingChanged(_ sender: PasswordTextField)
    func editingDidEnd(_ sender: PasswordTextField)
}

class PasswordTextField: UIView {
    
    /**
     A function one passes in to do custom validation on the text field.
     
     - Parameter: textValue: The value of text to validate
     - Returns: A Bool indicating whether text is valid, and if not a String containing an error message
     */
    typealias CustomValidation = (_ textValue: String?) -> (Bool, String)?
    
    let passwordTextField = UITextField()
    let dividerView = UIView()
    let errorLabel = UILabel()
    let padlockImageView = UIImageView(image: UIImage(systemName: "lock.fill"))
    let eyeButton = UIButton(type: .custom)
    
    let placeHolderText: String
    let errorLabelIsHidden: Bool
    var customValidation: CustomValidation?
    weak var delegate: PasswordTextFieldDelegate?
    
    var text: String? {
        get {
            return passwordTextField.text
        }
        set {
            passwordTextField.text = newValue
        }
    }
    
    init(placeHolderText: String, errorLabelIsHidden: Bool) {
        self.placeHolderText = placeHolderText
        self.errorLabelIsHidden = errorLabelIsHidden
        
        super.init(frame: .zero)
        
        style()
        layout()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override var intrinsicContentSize: CGSize {
        return CGSize(width: 200, height: 55)
    }
}
extension PasswordTextField {
    func style(){
        translatesAutoresizingMaskIntoConstraints = false
//        backgroundColor = .systemOrange
        
        padlockImageView.translatesAutoresizingMaskIntoConstraints = false
        
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        passwordTextField.placeholder = placeHolderText
        passwordTextField.isSecureTextEntry = false
        passwordTextField.delegate = self
        passwordTextField.keyboardType = .asciiCapable
        passwordTextField.attributedPlaceholder = NSAttributedString(string: placeHolderText, attributes: [NSAttributedString.Key.foregroundColor:UIColor.secondaryLabel])
        passwordTextField.addTarget(self, action: #selector(textFieldEditingChanged), for: .editingChanged)
        
        eyeButton.translatesAutoresizingMaskIntoConstraints = false
        eyeButton.setImage(UIImage(systemName: "eye.circle"), for: .normal)
        eyeButton.setImage(UIImage(systemName: "eye.slash.circle"), for: .selected)
        eyeButton.addTarget(self, action: #selector(togglePasswordView), for: .touchUpInside)
        
        dividerView.translatesAutoresizingMaskIntoConstraints = false
        dividerView.backgroundColor = .separator
        
        errorLabel.translatesAutoresizingMaskIntoConstraints = false
        errorLabel.textAlignment = .left
        errorLabel.textColor = .systemRed
        errorLabel.font = UIFont.preferredFont(forTextStyle: .footnote)
        errorLabel.text = "Your password must meet requirements below"
        errorLabel.adjustsFontSizeToFitWidth = true // fazla uzun labellarda sığdırır
        errorLabel.numberOfLines = 0
        errorLabel.minimumScaleFactor = 0.8
        errorLabel.lineBreakMode = .byWordWrapping
        errorLabel.isHidden = errorLabelIsHidden
        
        
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
            bottomAnchor.constraint(equalToSystemSpacingBelow: errorLabel.bottomAnchor, multiplier: 1)
        ])
        
        //CHCR  who will hug, who will loose
        padlockImageView.setContentHuggingPriority(UILayoutPriority.defaultHigh, for: .horizontal)
        passwordTextField.setContentHuggingPriority(UILayoutPriority.defaultLow, for: .horizontal)
        eyeButton.setContentHuggingPriority(UILayoutPriority.defaultHigh, for: .horizontal)
    }
}

//Actions
extension PasswordTextField {
    
    @objc func togglePasswordView(_sender: Any){
        passwordTextField.isSecureTextEntry.toggle()
        eyeButton.isSelected.toggle()
    }
    
    @objc func textFieldEditingChanged(_ sender: UITextField){
//        print("foo - \(sender.text)")
        delegate?.editingChanged(self)
    }
}
// MARK: - UITextFieldDelegate
extension PasswordTextField: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        passwordTextField.endEditing(true)
        return true
    }
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        return true
        
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        delegate?.editingDidEnd(self)
    }
}

// MARK: - Validation
// typealias CustomValidation = (_ textValue: String?) -> (Bool, String)?  0/1
extension PasswordTextField {
    func validate() -> Bool {
        if let customValidation = customValidation,
           let customValidationResult = customValidation(text),
           customValidationResult.0 == false {
            showError(customValidationResult.1)
            return false
        }
        clearError()
        return true
    }
    
    private func showError(_ errorMessage:String) {
        errorLabel.isHidden = false
        errorLabel.text = ""
    }
    private func clearError() {
        errorLabel.isHidden = true
        errorLabel.text = ""
    }
}



