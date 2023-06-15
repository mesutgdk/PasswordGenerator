//
//  StatusView.swift
//  Password
//
//  Created by Mesut Gedik on 15.06.2023.
//

import Foundation
import UIKit

class StatusView: UIView {
    
    let stackView = UIStackView()
    let imageView = UIImageView()
    let label = UILabel()
    
    let checkImage: UIImage
    let statusLabelText: String
    
    init(checkImage: UIImage, statusLabelText: String) {
        self.checkImage = checkImage
        self.statusLabelText = statusLabelText
        
        super.init(frame: .zero)
        
        style()
        layout()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override var intrinsicContentSize: CGSize {
        return CGSize(width: 200, height: 50)
    }
}
extension StatusView {
    func style(){
        translatesAutoresizingMaskIntoConstraints = false
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.spacing = 8
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = checkImage
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
//        statusLabel.textColor = .systemRed
        label.font = UIFont.preferredFont(forTextStyle: .subheadline)
        label.text = statusLabelText
        label.textColor = .secondaryLabel
//        statusLabel.adjustsFontSizeToFitWidth = true // fazla uzun labellarda sığdırır
//        statusLabel.numberOfLines = 0
//        statusLabel.minimumScaleFactor = 0.8
//        statusLabel.lineBreakMode = .byWordWrapping
        label.isHidden = false
        
    }
    func layout() {
        stackView.addArrangedSubview(imageView)
        stackView.addArrangedSubview(label)
        addSubview(stackView)
        
        //stackView
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor),
            trailingAnchor.constraint(equalTo: stackView.trailingAnchor)
        ])
        
        //CHCR  who will hug, who will loose
        imageView.setContentHuggingPriority(UILayoutPriority.defaultHigh, for: .horizontal)
        label.setContentHuggingPriority(UILayoutPriority.defaultLow, for: .horizontal)
        
        //Image
        NSLayoutConstraint.activate([
            imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor)
        ])
    }
}
