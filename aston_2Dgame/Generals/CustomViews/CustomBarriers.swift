//
//  CustomBarriers.swift
//  aston_2Dgame
//
//  Created by Анастасия on 29.12.2023.
//

import UIKit

extension UIView {
    class func  barrier(color: UIColor) -> UIView  {
         let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = color
        return view
    }
}
