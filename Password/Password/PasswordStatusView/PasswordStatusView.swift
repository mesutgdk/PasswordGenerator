//
//  PasswordStatusView.swift
//  Password
//
//  Created by Mesut Gedik on 15.06.2023.
//

import Foundation
import UIKit

class PasswordStatusView: UIView {
    
    let statusLabel = UILabel()
    
    let stackView = UIStackView()
    
    let lengthStatusView = StatusLineView(statusLabelText: "8-32 characters (no spaces)")
    let uppercaseStatusView = StatusLineView(statusLabelText: "upper letter (A-Z)")
    let lowercaseStatusView = StatusLineView(statusLabelText: "lowercase")
    let digitStatusView = StatusLineView(statusLabelText: "digit (0-9)")
    let specialCharacterStatusView = StatusLineView(statusLabelText: "special Character(e.g. !@#$%^)")
    
    // used to determine if i reset criteria back to emty state(⚪️)
    private var shouldResetCriteria: Bool = true
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        style()
        layout()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override var intrinsicContentSize: CGSize {
        return CGSize(width: 200, height: 160)
    }
}
extension PasswordStatusView {
    func style(){
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .tertiarySystemFill
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 8
        stackView.distribution = .equalCentering
        
        lengthStatusView.translatesAutoresizingMaskIntoConstraints = false
        uppercaseStatusView.translatesAutoresizingMaskIntoConstraints = false
        lowercaseStatusView.translatesAutoresizingMaskIntoConstraints = false
        digitStatusView.translatesAutoresizingMaskIntoConstraints = false
        specialCharacterStatusView.translatesAutoresizingMaskIntoConstraints = false

        statusLabel.translatesAutoresizingMaskIntoConstraints = false
        statusLabel.numberOfLines = 0
        statusLabel.lineBreakMode = .byWordWrapping
        statusLabel.attributedText = makeStatusMessage()
        
        layer.cornerRadius = 5
        clipsToBounds = true
        
    }
    func layout() {
        stackView.addArrangedSubview(lengthStatusView)
        stackView.addArrangedSubview(statusLabel)
        stackView.addArrangedSubview(uppercaseStatusView)
        stackView.addArrangedSubview(lowercaseStatusView)
        stackView.addArrangedSubview(digitStatusView)
        stackView.addArrangedSubview(specialCharacterStatusView)
        
        addSubview(stackView)
        
        //StackView
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalToSystemSpacingBelow: topAnchor, multiplier: 2),
            stackView.leadingAnchor.constraint(equalToSystemSpacingAfter: leadingAnchor, multiplier: 2),
            trailingAnchor.constraint(equalToSystemSpacingAfter: stackView.trailingAnchor, multiplier: 2),
            bottomAnchor.constraint(equalToSystemSpacingBelow: stackView.bottomAnchor, multiplier: 2)
        ])
    }
}
//Actions
extension PasswordStatusView {
    private func makeStatusMessage() -> NSAttributedString {
        var plainTextAttributes = [NSAttributedString.Key: AnyObject]()
        plainTextAttributes[.font] = UIFont.preferredFont(forTextStyle: .subheadline)
        plainTextAttributes[.foregroundColor] = UIColor.secondaryLabel
        
        var boldTextAttributes = [NSAttributedString.Key: AnyObject]()
        boldTextAttributes[.foregroundColor] = UIColor.label
        boldTextAttributes[.font] = UIFont.preferredFont(forTextStyle: .subheadline)

        let attrText = NSMutableAttributedString(string: "Use at least ", attributes: plainTextAttributes)
        attrText.append(NSAttributedString(string: "3 of these 4 ", attributes: boldTextAttributes))
        attrText.append(NSAttributedString(string: "criteria when setting your password:", attributes: plainTextAttributes))

        return attrText
    }
}

extension PasswordStatusView {
    func updateDisplay(_ text: String) {
        let lengthAndNoSpaceMet = PasswordStatsCriteria.lenghtAndNoSpaceMet(text)
        let upperCaseMet = PasswordStatsCriteria.upperCaseMet(text)
        
        if shouldResetCriteria {
            // inline validation (✅ or ⚪️ ) ternitariy operator
            lengthAndNoSpaceMet ? lengthStatusView.isCriteriaOK = true : lengthStatusView.reset()
            
            upperCaseMet ? uppercaseStatusView.isCriteriaOK = true : uppercaseStatusView.reset()
        }
    }
}
