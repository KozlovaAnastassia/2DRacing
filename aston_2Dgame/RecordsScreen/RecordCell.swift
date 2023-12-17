//
//  RecordCell.swift
//  aston_2Dgame
//
//  Created by Анастасия on 30.11.2023.
//

import UIKit

private extension CGFloat {
    static let stackSpacing = 60.0
    static let cornerRadiusMultiplier = 2.0
}

final class RecordCell: UITableViewCell {
    
    static var identifier: String {"\(Self.self)"}
    
    private var avatarImage: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = GeneralConstants.Colors.gray
        view.layer.cornerRadius = GeneralConstants.ImageSize.width/CGFloat.cornerRadiusMultiplier
        view.clipsToBounds = true
        view.widthAnchor.constraint(equalToConstant: GeneralConstants.ImageSize.width).isActive = true
        view.heightAnchor.constraint(equalToConstant: GeneralConstants.ImageSize.height).isActive = true
        view.contentMode = .scaleToFill
        return view
    }()
    
    private var nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = GeneralConstants.Fonts.heavyFont
        return label
    }()
    
    private var scoreLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = GeneralConstants.Fonts.heavyFont
        return label
    }()
    
    private lazy var stackView: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.alignment = .center
        stack.axis = .horizontal
        stack.spacing = CGFloat.stackSpacing
        
        stack.addArrangedSubview(avatarImage)
        stack.addArrangedSubview(nameLabel)
        stack.addArrangedSubview(scoreLabel)
        
        return stack
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addViews()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError(GeneralConstants.Errors.initError)
    }
     
    override func prepareForReuse() {
        super.prepareForReuse()
        avatarImage.image = nil
        nameLabel.text = nil
        scoreLabel.text = nil
    }
    
    private func addViews() {
        contentView.addSubview(stackView)
    }
     
     private func setConstraints() {
         NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: GeneralConstants.Offsets.offset),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: GeneralConstants.Offsets.inset),
            stackView.centerYAnchor.constraint(equalTo: centerYAnchor),
         ])
     }
    
    
    func configure(_ model: RecordModel) {
        nameLabel.text = model.name
        scoreLabel.text = model.score
        avatarImage.image = StorageManager().getImage(model.name)
   }
}
