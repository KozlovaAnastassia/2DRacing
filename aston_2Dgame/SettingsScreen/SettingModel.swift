//
//  SettingModel.swift
//  aston_2Dgame
//
//  Created by Анастасия on 21.11.2023.
//

import UIKit


struct SettingModel {
    var currentLevel: String?
    var name: String?
    var image: UIImage?
    var id: Int?
    
    let levelsOfgame = LevelsOfgame.allCases.map { "\($0)" }
}
