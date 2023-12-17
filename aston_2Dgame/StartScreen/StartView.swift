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
    
    var buttonStart: UIButton = {
        let button = UIButton()
        button.setTitle(String.startTitle, for: .normal)
        button.setTitleColor( GeneralConstants.Colors.blue, for: .highlighted)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.tag = 1
        button.backgroundColor = .blue
        return button
     }()
     
    var buttonSettings: UIButton = {
        let button = UIButton()
        button.setTitle(String.settingsTitle, for: .normal)
        button.setTitleColor( GeneralConstants.Colors.blue, for: .highlighted)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.tag = 2
        button.backgroundColor = .blue
        return button
     }()
     
    var buttonRecords: UIButton = {
        let button = UIButton()
        button.setTitle(String.recordsTitle, for: .normal)
        button.setTitleColor( GeneralConstants.Colors.blue, for: .highlighted)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.tag = 3
        button.backgroundColor = .blue
        return button
     }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        addSubviews()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError(GeneralConstants.Errors.initError)
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
            buttonStart.heightAnchor.constraint(equalToConstant: GeneralConstants.ButtonSize.height),
            buttonStart.widthAnchor.constraint(equalToConstant: GeneralConstants.ButtonSize.width)
        ])
        
        NSLayoutConstraint.activate([
            buttonSettings.centerXAnchor.constraint(equalTo: centerXAnchor),
            buttonSettings.centerYAnchor.constraint(equalTo: centerYAnchor),
            buttonSettings.heightAnchor.constraint(equalToConstant: GeneralConstants.ButtonSize.height),
            buttonSettings.widthAnchor.constraint(equalToConstant: GeneralConstants.ButtonSize.width)
        ])
        
        NSLayoutConstraint.activate([
            buttonRecords.centerXAnchor.constraint(equalTo: centerXAnchor),
            buttonRecords.topAnchor.constraint(equalTo: buttonSettings.bottomAnchor, constant: GeneralConstants.Offsets.offset),
            buttonRecords.heightAnchor.constraint(equalToConstant: GeneralConstants.ButtonSize.height),
            buttonRecords.widthAnchor.constraint(equalToConstant: GeneralConstants.ButtonSize.width)
        ])
    }
}
