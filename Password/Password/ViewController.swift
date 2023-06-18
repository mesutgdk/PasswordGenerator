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
    let passwordTextField2 = PasswordTextField(placeHolderText: "Re-enter new password")
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
        setupConfirmPassword()
        setupKeyboardHiding()
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
            
            // Criteria Met
            self.passwordStatusView.updateDisplay(text)
            if !self.passwordStatusView.validate(text) {
                return (false, "Your password must meet the requirement below")
            }
            return (true, "")
        
        }
        passwordTextField.customValidation = newPasswordValidation
        passwordTextField.delegate = self
    }
    private func setupConfirmPassword() {
        let confirmPasswordValidation: CustomValidation = { text in
            guard let text = text, !text.isEmpty else {
                return (false, "Enter your password.")
            }
            guard text == self.passwordTextField.text else {
                return (false, "Passwords do not match.")
            }
            
            return (true, "")
        }
        
        passwordTextField2.customValidation = confirmPasswordValidation
        passwordTextField2.delegate = self
    }
    private func setupKeyboardHiding(){
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    private func style(){
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 20
        
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        passwordTextField2.translatesAutoresizingMaskIntoConstraints = false
//        passwordTextField.delegate = self // yukarı validate'e aldım

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
            passwordStatusView.shouldResetCriteria = false
            _ = passwordTextField.validate()
        } else if sender == passwordTextField2 {
            _ = passwordTextField2.validate()
        }
    }
    
}
//Actions 1. Reset button 2. Keyboard Actions
extension ViewController {
    @objc func resetPasswordButtonTapped(){
        
    }
    
    @objc func keyboardWillShow(sender: NSNotification) { // keyboard bilgilerini burda alıyoruz
//        view.frame.origin.y = view.frame.origin.y - 200 // it push all view 200 pxl up
        guard let userInfo = sender.userInfo,
              let keyboardFrame = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue,
              let currentTextField = UIResponder.currentFirst() as? UITextField else {return}
        
//        print("foo - userInfo \(userInfo)")
//        print("foo - keyboardFrame \(keyboardFrame)")
//        print("foo - currenttextField \(currentTextField)")
        
        // check if the top of the keyboard is above the bottom of the currently focused textbox
        let keyboardTopY = keyboardFrame.cgRectValue.origin.y
        // let textFieldBottomY = currentTextField.frame.origin.y + currentTextField.frame.size.height
        // textfield kendi koordinat sisteminde dönüyor, çalışmıyor, yukarıdaki yerine parent view koordinat sistemine çevireceğiz
        let convertedTextFieldFrame = view.convert(currentTextField.frame, from: currentTextField.superview)
        
        let textFieldBottomY = (convertedTextFieldFrame.origin.y + convertedTextFieldFrame.size.height)
        
        // if textField bottom is below keyboard bottom - push the frame up
        if textFieldBottomY > keyboardTopY {
            //adjust view up
            let textBoxY = convertedTextFieldFrame.origin.y
            let newFrameY = (textBoxY - keyboardTopY/2) * -1
            view.frame.origin.y = newFrameY
        }

    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        view.frame.origin.y = 0
    }
}

