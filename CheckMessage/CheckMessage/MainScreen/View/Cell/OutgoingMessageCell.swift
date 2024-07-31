//
//  OutgoingMessageCell.swift
//  CheckMessage
//
//  Created by Dmytro on 30.07.2024.
//

import UIKit

class OutgoingMessageCell: UITableViewCell, CellIdentifiable {
    
    private enum Const {
        static let horizontalOffset: CGFloat = 10
        static let avatarImageSize: CGFloat = 40
        static let verticalOffset: CGFloat = 20
        static let messgeSideOffset: CGFloat = 10
        static let bubbleCornerRadius: CGFloat = 10
        
    }
    
    
    func updateWithModel(_ viewModel: MessageViewModel) {
        messageLabel.text = viewModel.message
        userAvatarImage.image = viewModel.image
    }
    
    private lazy var messageLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private lazy var messageContainer: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(red: 204/255, green: 255/255, blue: 204/255, alpha: 0.3)
        view.layer.cornerRadius = Const.bubbleCornerRadius
        view.layer.masksToBounds = true

        return view
    }()
    
    private lazy var userAvatarImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = UIColor(red: 204/255, green: 255/255, blue: 204/255, alpha: 0.3)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = Const.avatarImageSize/2
        imageView.layer.masksToBounds = true
        imageView.layer.borderWidth = 2
        imageView.layer.borderColor = UIColor(red: 204/255, green: 255/255, blue: 204/255, alpha: 0.3).cgColor
        
        return imageView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        setupSubviews()
        setupLayout()
    }
    
    private func setupSubviews() {
        contentView.addSubview(messageContainer)
        contentView.addSubview(messageLabel)
        contentView.addSubview(userAvatarImage)
    }
    
    private func setupLayout() {
        
        
        let screen = UIScreen.screens.first
        let width = screen?.bounds.width ?? 1
        let maxMessageWidth = width/3*2
        
        NSLayoutConstraint.activate([
            userAvatarImage.topAnchor.constraint(greaterThanOrEqualTo: contentView.topAnchor, constant: Const.verticalOffset),
            userAvatarImage.widthAnchor.constraint(equalToConstant: Const.avatarImageSize),
            userAvatarImage.heightAnchor.constraint(equalToConstant: Const.avatarImageSize),
            userAvatarImage.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor, constant: -Const.verticalOffset),
            userAvatarImage.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            
            
            messageContainer.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Const.verticalOffset),
            messageContainer.leftAnchor.constraint(equalTo: userAvatarImage.rightAnchor, constant: Const.horizontalOffset),
            messageContainer.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -Const.horizontalOffset),
            messageContainer.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor, constant: -Const.verticalOffset),
            messageContainer.widthAnchor.constraint(equalToConstant: maxMessageWidth),
            
            messageLabel.topAnchor.constraint(equalTo: messageContainer.topAnchor, constant: Const.messgeSideOffset),
            messageLabel.rightAnchor.constraint(equalTo: messageContainer.rightAnchor, constant: -Const.messgeSideOffset),
            messageLabel.bottomAnchor.constraint(equalTo: messageContainer.bottomAnchor, constant: -Const.messgeSideOffset),
            messageLabel.leftAnchor.constraint(equalTo: messageContainer.leftAnchor, constant: Const.messgeSideOffset)
            
        ])
    }
}
