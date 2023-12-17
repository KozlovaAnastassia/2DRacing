//
//  RaceModel.swift
//  aston_2Dgame
//
//  Created by Анастасия on 13.12.2023.
//

import UIKit

private extension Double {
    static let easySpeed = 5.0
    static let mediumSpeed = 3.0
    static let hardSpeed = 2.0
    
    static let scoreConstantAddition = 0.5
    static let scoreDefault = 0.0
}

private extension CGFloat {
    static let randomXWightDivider = 3.0
}


struct RaceModel {
    var speed: Double
    var score: Double
    var randomX: Int
    var gameLevel: String
    
    var isStart = true
    var isGameFinished = false
    var isControllerClosed = false
    
    init(gameLevel: String) {
        self.gameLevel = gameLevel
        self.randomX = Int.zero
        self.score = Double.scoreDefault
        self.speed = Double.easySpeed
    }
    
    
    mutating func getRandomX(view: UIView) {
        self.randomX = Int(Float.random(in: Float.zero...Float(view.frame.width / CGFloat.randomXWightDivider)))
    }
    
    mutating func defineSpeed(){
        switch gameLevel {
        case "\(LevelsOfgame.easy)": self.speed = Double.easySpeed;
        case "\(LevelsOfgame.medium)": self.speed = Double.mediumSpeed;
        case "\(LevelsOfgame.hard)": self.speed = Double.hardSpeed;
        default: self.speed = Double.easySpeed;
        }
    }
    
    mutating func updateScore() {
            if isGameFinished {
                self.score = Double.scoreDefault
            } else {
                self.score += Double.scoreConstantAddition
            }
        }
    
}
