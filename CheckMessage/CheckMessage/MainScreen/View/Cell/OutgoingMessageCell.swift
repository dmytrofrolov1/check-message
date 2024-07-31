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
    }
    
    
    lazy var messageLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
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
        contentView.addSubview(messageLabel)
    }
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
            messageLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Const.horizontalOffset),
            messageLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            messageLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -Const.horizontalOffset),
            messageLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor)
        ])
    }
}
