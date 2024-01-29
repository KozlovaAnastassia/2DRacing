//
//  RecordCell.swift
//  aston_2Dgame
//
//  Created by Анастасия on 30.11.2023.
//

import UIKit

private extension CGFloat {
    static let stackSpacing = 60.0
}

final class RecordCell: UITableViewCell {
    
    static var identifier: String {"\(Self.self)"}
    
    private var nameLabel = UILabel.labelHeader(text: "")
    private var scoreLabel = UILabel.labelHeader(text: "")
    private var avatarImage = UIImageView.avatarImage(height: GeneralConstants.ImageSize.height)
    
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
    
    func configure(_ model: SettingModel) {
        nameLabel.text = model.name
        avatarImage.image = UIImage(data: model.image ?? Data())
        if let score = model.score {
            scoreLabel.text = String(score)
        }
   }
}
