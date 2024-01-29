//
//  CustomLabel.swift
//  aston_2Dgame
//
//  Created by Анастасия on 29.12.2023.
//

import UIKit

extension UILabel {
    class func  labelHeader(text: String) -> UILabel  {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = text
        label.font = GeneralConstants.Fonts.heavyFont
        return label
    }
    
    class func  labelScore(font: UIFont) -> UILabel  {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = font
        return label
    }
}
