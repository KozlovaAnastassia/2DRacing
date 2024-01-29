//
//  StartView.swift
//  aston_2Dgame
//
//  Created by Анастасия on 12.12.2023.
//

import UIKit

private extension String {
    static let startTitle = "Strat"
    static let settingsTitle = "Settings"
    static let recordsTitle = "Records"
}

final class StartView: UIView {
    
    var buttonStart = UIButton.standartButton(title: String.startTitle)
    var buttonSettings = UIButton.standartButton(title: String.settingsTitle)
    var buttonRecords = UIButton.standartButton(title: String.recordsTitle)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        addSubviews()
        setConstraints()
        setTag()
    }
    
    required init?(coder: NSCoder) {
        fatalError(GeneralConstants.Errors.initError)
    }
    
    private func setTag() {
        buttonStart.tag = 1
        buttonSettings.tag = 2
        buttonRecords.tag = 3
    }
    
    private func addSubviews() {
        addSubview(buttonStart)
        addSubview(buttonSettings)
        addSubview(buttonRecords)
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            buttonStart.centerXAnchor.constraint(equalTo: centerXAnchor),
            buttonStart.bottomAnchor.constraint(equalTo: buttonSettings.topAnchor, constant: GeneralConstants.Offsets.inset),
        ])
        
        NSLayoutConstraint.activate([
            buttonSettings.centerXAnchor.constraint(equalTo: centerXAnchor),
            buttonSettings.centerYAnchor.constraint(equalTo: centerYAnchor),
        ])
        
        NSLayoutConstraint.activate([
            buttonRecords.centerXAnchor.constraint(equalTo: centerXAnchor),
            buttonRecords.topAnchor.constraint(equalTo: buttonSettings.bottomAnchor, constant: GeneralConstants.Offsets.offset),
        ])
    }
}
