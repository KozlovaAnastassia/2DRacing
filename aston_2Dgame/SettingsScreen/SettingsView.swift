//
//  SettingsView.swift
//  aston_2Dgame
//
//  Created by Анастасия on 21.11.2023.
//

import UIKit

private extension String {
    static let nameLabelText = "Player name:"
    static let textFieldPlaceholder = "Enter name of player"
    static let levelLabelText = "Select level:"
    static let buttonStartGameTitle = "Save & start game"
    static let buttonResetTitle = "Reset"
}

private extension CGFloat {
    static let topOffset = 100.0
    static let spaceAfterLevelPicker = 100.0
    static let spaceAfterlevelLabel = 0.0
    static let imageSizeMultiplier = 2.0
}

final class SettingsView: UIView {
    
    var buttonStartGame = UIButton.standartButton(title: String.buttonStartGameTitle)
    var buttonReset = UIButton.standartButton(title: String.buttonResetTitle)
    
    var levelLabel = UILabel.labelHeader(text: String.levelLabelText)
    var nameLabel = UILabel.labelHeader(text: String.nameLabelText)
    var avatarImage = UIImageView.avatarImage(height: GeneralConstants.ImageSize.height * CGFloat.imageSizeMultiplier)
    
    let imagePicker: UIImagePickerController = {
        let imagePicker = UIImagePickerController()
        return imagePicker
    }()
    
    var textField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
         textField.placeholder = String.textFieldPlaceholder
        textField.borderStyle = .bezel
        return textField
    }()
    
    var levelPicker: UIPickerView = {
        let picker = UIPickerView()
        picker.translatesAutoresizingMaskIntoConstraints = false
        return picker
    }()
     
    private lazy var stackView: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.alignment = .center
        stack.axis = .vertical
        stack.spacing = GeneralConstants.Offsets.offset
        
        stack.addArrangedSubview(avatarImage)
        stack.addArrangedSubview(nameLabel)
        stack.addArrangedSubview(textField)
        stack.addArrangedSubview(levelLabel)
        stack.addArrangedSubview(levelPicker)
        stack.addArrangedSubview(buttonStartGame)
        stack.addArrangedSubview(buttonReset)
    
        stack.setCustomSpacing(CGFloat.spaceAfterlevelLabel, after: levelLabel)
        stack.setCustomSpacing(CGFloat.spaceAfterLevelPicker, after: levelPicker)
        
        return stack
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
        addSubview(stackView)
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: GeneralConstants.Offsets.offset),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: GeneralConstants.Offsets.inset),
            stackView.topAnchor.constraint(equalTo: topAnchor, constant: CGFloat.topOffset),
        ])
    }
    
}
