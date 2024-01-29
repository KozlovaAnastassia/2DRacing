//
//  CustomImageView.swift
//  aston_2Dgame
//
//  Created by Анастасия on 29.12.2023.
//

import UIKit

private extension CGFloat {
    static let cornerRadiusMultiplier = 2.0
}

extension UIImageView {
    class func  avatarImage(height: CGFloat) -> UIImageView  {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = GeneralConstants.Colors.gray
        view.layer.cornerRadius = height/CGFloat.cornerRadiusMultiplier
        view.clipsToBounds = true
        view.widthAnchor.constraint(equalToConstant: height).isActive = true
        view.heightAnchor.constraint(equalToConstant: height).isActive = true
        view.contentMode = .scaleToFill
        return view
    }
}

