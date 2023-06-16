//
//  ViewController.swift
//  TextFieldPlayField
//
//  Created by Mesut Gedik on 16.06.2023.
//

import UIKit

class ViewController: UIViewController {

    let textField = UITextField()
    let button = UIButton (type: .system)
    let label = UILabel()
    
    var textWroten : String? {
        return textField.text
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        style()
        layout()
    }
    
    private func style(){
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.delegate = self
        textField.placeholder = "Type Me"
        textField.textAlignment = .center
        textField.backgroundColor = .systemGray6
        
        // extra interaction
        textField.addTarget(self, action: #selector(textFieldEditingChanged), for: .editingChanged)

        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.text = "Write something"
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
      
        
        button.translatesAutoresizingMaskIntoConstraints = false
        button.configuration = .filled()
        button.configuration?.imagePadding = 8 // for indicator spacing
        button.setTitle("Print", for: [])
        button.addTarget(self, action: #selector(printText), for: .primaryActionTriggered)
        
        
        
    }
    private func layout(){
        view.addSubview(textField)
        view.addSubview(label)
        view.addSubview(button)
        
        NSLayoutConstraint.activate([
            textField.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 2),
            textField.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            view.trailingAnchor.constraint(equalToSystemSpacingAfter: textField.trailingAnchor, multiplier: 2)
        ])
        
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: textField.leadingAnchor),
            label.topAnchor.constraint(equalToSystemSpacingBelow: textField.bottomAnchor, multiplier: 2),
            textField.trailingAnchor.constraint(equalTo: label.trailingAnchor)
            
        ])
        
        NSLayoutConstraint.activate([
            button.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 7),
            view.safeAreaLayoutGuide.bottomAnchor.constraint(equalToSystemSpacingBelow: button.bottomAnchor, multiplier: 7),
            view.trailingAnchor.constraint(equalToSystemSpacingAfter: button.trailingAnchor, multiplier: 7),
            button.heightAnchor.constraint(equalToConstant: 30)
        ])
    }
    @objc func printText(){
        print(textWroten!)
        label.text = textWroten
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
        return true
    }
    
    // if implemented, called in place of textFieldDidEndEditing: ?
    func textFieldDidEndEditing(_ textField: UITextField) {
        label.text = textWroten
    }
    
    // detect - keypress
    // return NO to not change text
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let word = textField.text ?? ""
        let char = string
        print("Default - shouldChangeCharactersIn: \(word) \(char)")
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

// MARK: - Extra Actions
extension ViewController {
    @objc func textFieldEditingChanged(_ sender: UITextField) {
        print("Extra - textFieldEditingChanged: \(sender.text)")
        label.text = sender.text
    }
}
