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
    
    let lengthStatusView = StatusView(statusLabelText: "8-32 characters (no spaces)")
    let uppercaseStatusView = StatusView(statusLabelText: "upper letter (A-Z)")
    let lowercaseStatusView = StatusView(statusLabelText: "lowercase")
    let digitStatusView = StatusView(statusLabelText: "digit (0-9)")
    let specialCharacterStatusView = StatusView(statusLabelText: "special Character(e.g. !@#$%^)")
    
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
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 8
        
        lengthStatusView.translatesAutoresizingMaskIntoConstraints = false
        uppercaseStatusView.translatesAutoresizingMaskIntoConstraints = false
        lowercaseStatusView.translatesAutoresizingMaskIntoConstraints = false
        digitStatusView.translatesAutoresizingMaskIntoConstraints = false
        specialCharacterStatusView.translatesAutoresizingMaskIntoConstraints = false

        statusLabel.translatesAutoresizingMaskIntoConstraints = false
        statusLabel.textAlignment = .justified
        statusLabel.textColor = .tertiaryLabel
        statusLabel.font = UIFont.preferredFont(forTextStyle: .footnote)
        statusLabel.text = "Use at least 3 of 4 Criteria when setting your password:"
        statusLabel.adjustsFontSizeToFitWidth = true // fazla uzun labellarda sığdırır
        statusLabel.numberOfLines = 0
        statusLabel.minimumScaleFactor = 0.8
        statusLabel.lineBreakMode = .byWordWrapping
//        statusLabel.isHidden = errorLabelIsHidden
        
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
