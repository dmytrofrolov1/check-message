//
//  SendMessgeView.swift
//  CheckMessage
//
//  Created by Dmytro on 31.07.2024.
//

import UIKit

protocol SendMessgeViewDelegate: AnyObject {
    func didTapSend(message: String)
}

class SendMessgeView: UIView {
    private enum Const {
        static let horizontalOffset: CGFloat = 10
        static let verticalOffset: CGFloat = 10
        
        enum TextField {
            static let borderWidth: CGFloat = 2
            static let cornerRadius: CGFloat = 5
            static let height: CGFloat = 30
        }
        
        enum Button {
            static let width: CGFloat = 50
        }
    }

    
    weak var delegate: SendMessgeViewDelegate?
    
    private lazy var textField: UITextField = {
        let view = UITextField()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.borderWidth = Const.TextField.borderWidth
        view.layer.cornerRadius = Const.TextField.cornerRadius
        view.layer.borderColor = UIColor(red: 204/255, green: 255/255, blue: 204/255, alpha: 0.7).cgColor
        view.layer.masksToBounds = true
        view.returnKeyType = .send
        view.delegate = self

        return view
    }()
    
    private lazy var button: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("SEND", for: .normal)
        button.addTarget(self, action: #selector(sendAction), for: .touchUpInside)
        
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
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
        addSubview(textField)
        addSubview(button)
    }
    
    @objc
    private func sendAction() {
        delegate?.didTapSend(message: textField.text ?? "")
        textField.text = ""
    }
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
            textField.topAnchor.constraint(equalTo: topAnchor, constant: Const.verticalOffset),
            textField.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -Const.verticalOffset),
            textField.leftAnchor.constraint(equalTo: leftAnchor, constant: Const.horizontalOffset),
            textField.heightAnchor.constraint(equalToConstant: Const.TextField.height),
            
            button.rightAnchor.constraint(equalTo: rightAnchor, constant: -Const.horizontalOffset),
            button.topAnchor.constraint(equalTo: topAnchor),
            button.bottomAnchor.constraint(equalTo: bottomAnchor),
            button.leftAnchor.constraint(equalTo: textField.rightAnchor, constant: Const.horizontalOffset),
            button.widthAnchor.constraint(equalToConstant: Const.Button.width),
            
        ])
    }
}

extension SendMessgeView: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        delegate?.didTapSend(message: textField.text ?? "")
        return true
    }
}
