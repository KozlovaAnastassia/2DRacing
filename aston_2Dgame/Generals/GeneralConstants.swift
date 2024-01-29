//
//  Constants.swift
//  aston_2Dgame
//
//  Created by Анастасия on 12.12.2023.
//

import UIKit

enum LevelsOfgame: CaseIterable {
    case easy, medium, hard
}

enum Diraction {
    case up, left, right, down
}

 enum GeneralConstants {
     enum ButtonSize {
         static let height: CGFloat = 50
         static let width: CGFloat = 200
     }
     
     enum Offsets {
         static let offset: CGFloat = 20
         static let inset: CGFloat = -20
     }
     
     enum ImageSize {
         static let height: CGFloat = 60
     }
     
     enum Defaults {
         static let score: Double = 0.0
     }
     
     enum UDKeys {
         static let currentLevel  = "currentLevel"
         static let name  = "name"
         static let id  = "id"
     }
     
     enum ImageName {
         static let placeholder  = "placeholder"
         static let background  = "bg"
         static let car  = "carImage"
         static let barrier  = "barrierImage"
     }
     
     enum Errors {
         static let initError  = "init(coder:) has not been implemented"
     }
     
     enum Fonts {
         static let heavyFont = UIFont.systemFont(ofSize: 20, weight: .heavy)
         static let scoreFont = UIFont.systemFont(ofSize: 30, weight: .heavy)
     }
     
     enum Colors {
         static let gray: UIColor =  .systemGray
         static let blue: UIColor =  .blue
     }
    
}
