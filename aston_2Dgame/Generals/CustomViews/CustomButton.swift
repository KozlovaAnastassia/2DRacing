//
//  CustomButton.swift
//  aston_2Dgame
//
//  Created by Анастасия on 29.12.2023.
//

import UIKit

private extension CGFloat {
    static let cornerRadius = 20.0
}

extension UIButton {
    class func standartButton(title: String) -> UIButton {
       let button = UIButton()
        button.setTitle(title, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.widthAnchor.constraint(equalToConstant: GeneralConstants.ButtonSize.width).isActive = true
        button.heightAnchor.constraint(equalToConstant: GeneralConstants.ButtonSize.height).isActive = true
        button.backgroundColor = .systemBlue
        button.setTitleColor(.systemBlue, for: .highlighted)
        button.layer.cornerRadius = CGFloat.cornerRadius
        return button
    }
}
