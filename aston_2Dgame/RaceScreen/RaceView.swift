//
//  RaceView.swift
//  aston_2Dgame
//
//  Created by Анастасия on 12.12.2023.
//

import UIKit

private extension CGFloat {
    static let locationDividerCarX = 2.0
    static let locationDividerBarrierRedX = 2.0
    static let locationDividerBarrierGreenX = 3.0
    static let locationDividerBarrierBlueX = 4.0
    static let locationDividerBarrierOrangeX = 5.0
    
    static let barrierHeightDividerMinuend = 4.0
    static let barrierHeightDividerSubtrahend = 5.0
    
    static let barrierWightDividerMinuend = 4.0
    static let barrierWightDividerSubtrahend = 5.0
    
    static let carViewHeightMultiplier = 1.7
    
    static let scoreLabelTopOffset = 50.0
}

final class RaceView: UIView {
    
    var carView = UIView.barrier(color: .magenta)
    var barrierViewRed = UIView.barrier(color: .red)
    var barrierViewGreen = UIView.barrier(color: .green)
    var barrierViewBlue = UIView.barrier(color: .blue)
    var barrierViewOrange = UIView.barrier(color: .orange)
    var scoreLabel = UILabel.labelScore(font: GeneralConstants.Fonts.scoreFont)
    
    var bgFirst: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = UIImage(named: GeneralConstants.ImageName.background)
        return image
    }()
    
    var bgSecond: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = UIImage(named: GeneralConstants.ImageName.background)
        return image
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .darkGray
        addSubviews()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError(GeneralConstants.Errors.initError)
    }
    
    private func addSubviews() {
        addSubview(bgFirst)
        addSubview(bgSecond)
        addSubview(barrierViewRed)
        addSubview(barrierViewGreen)
        addSubview(barrierViewBlue)
        addSubview(barrierViewOrange)
        addSubview(carView)
        addSubview(scoreLabel)
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            scoreLabel.topAnchor.constraint(equalTo: topAnchor, constant: CGFloat.scoreLabelTopOffset),
            scoreLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
        ])
        
        NSLayoutConstraint.activate([
            bgFirst.topAnchor.constraint(equalTo: topAnchor),
            bgFirst.leadingAnchor.constraint(equalTo: leadingAnchor),
            bgFirst.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            bgSecond.topAnchor.constraint(equalTo: bottomAnchor),
            bgSecond.leadingAnchor.constraint(equalTo: leadingAnchor),
            bgSecond.trailingAnchor.constraint(equalTo: trailingAnchor),
        ])
    }
    
    func adjustCarViewFrame() {
        let screenWidth = UIScreen.main.bounds.width
        let screenHeight = UIScreen.main.bounds.height
        let height = screenHeight/CGFloat.barrierHeightDividerMinuend - screenHeight/CGFloat.barrierHeightDividerSubtrahend
        let wigth = screenHeight/CGFloat.barrierWightDividerMinuend - screenHeight/CGFloat.barrierWightDividerSubtrahend
        
        carView.frame = CGRect(
            origin: CGPoint(x: screenWidth / CGFloat.locationDividerCarX, y: screenHeight - screenHeight / 6),
            size: CGSize(width: wigth, height: height*CGFloat.carViewHeightMultiplier)
        )
        
        barrierViewRed.frame = CGRect(
            origin: CGPoint(x: screenWidth / CGFloat.locationDividerBarrierRedX, y: -height),
            size: CGSize(width: wigth, height: height)
        )
        
        barrierViewGreen.frame = CGRect(
            origin: CGPoint(x: screenWidth / CGFloat.locationDividerBarrierGreenX, y: -height),
            size: CGSize(width: wigth, height: height)
        )
        
        barrierViewBlue.frame = CGRect(
            origin: CGPoint(x: screenWidth / CGFloat.locationDividerBarrierBlueX, y: -height),
            size: CGSize(width: wigth, height: height)
        )
        barrierViewOrange.frame = CGRect(
            origin: CGPoint(x: screenWidth / CGFloat.locationDividerBarrierOrangeX, y: -height),
            size: CGSize(width: wigth, height: height)
        )
    
    }
}
