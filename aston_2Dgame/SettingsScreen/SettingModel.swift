//
//  SettingModel.swift
//  aston_2Dgame
//
//  Created by Анастасия on 21.11.2023.
//

import UIKit


struct SettingModel: Codable {
    var currentLevel: String?
    var name: String?
    var image: Data?
    var id: Int?
    var score: Double?
    
    let levelsOfgame = LevelsOfgame.allCases.map { "\($0)" }
}
