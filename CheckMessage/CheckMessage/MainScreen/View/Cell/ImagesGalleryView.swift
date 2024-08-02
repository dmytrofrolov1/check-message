//
//  ImagesGalleryView.swift
//  CheckMessage
//
//  Created by Dmytro on 02.08.2024.
//

import UIKit

class ImagesGalleryView: UIView {
    
    private enum Const {
        static let imageSize: CGFloat = 100
    }
    
    private lazy var containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private lazy var horizontalStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.distribution = .fill
        stackView.spacing = 5
        stackView.backgroundColor = .clear
        
        return stackView
    }()
    
    
    func updateWithImages(images: [UIImage]) {
        for image in images {
            let imageView = UIImageView()
            imageView.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                imageView.widthAnchor.constraint(equalToConstant: 100),
                imageView.heightAnchor.constraint(equalToConstant: 100)
            ])
            imageView.image = image
            imageView.contentMode = .scaleAspectFit
            horizontalStackView.addArrangedSubview(imageView)
        }
    }
    
    private lazy var scrollView: UIScrollView = {
        let view = UIScrollView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
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
        addSubview(containerView)
        containerView.addSubview(scrollView)
        scrollView.addSubview(horizontalStackView)
    }
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: topAnchor),
            containerView.rightAnchor.constraint(equalTo: rightAnchor),
            containerView.bottomAnchor.constraint(equalTo: bottomAnchor),
            containerView.leftAnchor.constraint(equalTo: leftAnchor),
            
            scrollView.topAnchor.constraint(equalTo: containerView.topAnchor),
            scrollView.rightAnchor.constraint(equalTo: containerView.rightAnchor),
            scrollView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
            scrollView.leftAnchor.constraint(equalTo: containerView.leftAnchor),
            
            horizontalStackView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            horizontalStackView.rightAnchor.constraint(equalTo: scrollView.rightAnchor),
            horizontalStackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            horizontalStackView.leftAnchor.constraint(equalTo: scrollView.leftAnchor),
        ])
    }

}
