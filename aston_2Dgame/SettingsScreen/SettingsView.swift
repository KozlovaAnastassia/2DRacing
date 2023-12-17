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
    static let buttonStartGameTitle = "Save & star Game"
    static let buttonResetTitle = "Reset"
}

private extension CGFloat {
    static let topOffset = 100.0
    static let spaceAfterNameLabel = 10.0
    static let spaceAfterTextField = 80.0
    static let spaceAfterlevelLabel = 0.0
    static let imageSizeMultiplier = 2.0
}

final class SettingsView: UIView {
    
    var avatarImage: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .systemGray
        view.layer.cornerRadius = GeneralConstants.ImageSize.width
        view.clipsToBounds = true
        view.image = UIImage(named: GeneralConstants.ImageName.placeholder)
        view.widthAnchor.constraint(equalToConstant: GeneralConstants.ImageSize.width * CGFloat.imageSizeMultiplier).isActive = true
        view.heightAnchor.constraint(equalToConstant: GeneralConstants.ImageSize.height * CGFloat.imageSizeMultiplier).isActive = true
        view.contentMode = .scaleToFill
        return view
    }()
    
    let imagePicker: UIImagePickerController = {
        let imagePicker = UIImagePickerController()
        return imagePicker
    }()
    
    var nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = String.nameLabelText
         label.font = GeneralConstants.Fonts.heavyFont
        return label
    }()
    
    var textField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
         textField.placeholder = String.textFieldPlaceholder
        textField.borderStyle = .bezel
        return textField
    }()
    
    var levelLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = String.levelLabelText
        label.font = GeneralConstants.Fonts.heavyFont
        return label
    }()
    
    var levelPicker: UIPickerView = {
        let picker = UIPickerView()
        picker.translatesAutoresizingMaskIntoConstraints = false
        return picker
    }()
    
    var buttonStartGame: UIButton = {
       let button = UIButton()
        button.setTitle(String.buttonStartGameTitle, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.widthAnchor.constraint(equalToConstant: GeneralConstants.ButtonSize.width).isActive = true
        button.heightAnchor.constraint(equalToConstant: GeneralConstants.ButtonSize.height).isActive = true
        button.backgroundColor = .blue
        button.setTitleColor(.blue, for: .highlighted)
        return button
    }()
     
     
    var buttonReset: UIButton = {
        let button = UIButton()
         button.setTitle(String.buttonResetTitle, for: .normal)
         button.translatesAutoresizingMaskIntoConstraints = false
         button.widthAnchor.constraint(equalToConstant: GeneralConstants.ButtonSize.width).isActive = true
         button.heightAnchor.constraint(equalToConstant: GeneralConstants.ButtonSize.height).isActive = true
         button.backgroundColor = .blue
         button.setTitleColor(.blue, for: .highlighted)
         return button
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
        
        stack.setCustomSpacing(CGFloat.spaceAfterNameLabel, after: nameLabel)
        stack.setCustomSpacing(CGFloat.spaceAfterTextField, after: textField)
        stack.setCustomSpacing(CGFloat.spaceAfterlevelLabel, after: levelLabel)
        
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
