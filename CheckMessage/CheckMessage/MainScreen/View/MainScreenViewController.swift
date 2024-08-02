//
//  MainScreenViewController.swift
//  CheckMessage
//
//  Created by Dmytro on 29.07.2024.
//  Copyright (c) 2024 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit
import PhotosUI

class MainScreenViewController: UIViewController {
    
    private enum Const {
        static let defaultAnimationTime: TimeInterval = 0.3
    }

    var interactor: MainScreenBusinessLogic!
    var router: MainScreenRouterProtocol!

    private var sendViewBottomConstraint: NSLayoutConstraint?
    private var selectedImages = [UIImage]()
    private lazy var tableView: UITableView = {
        let view = UITableView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.keyboardDismissMode = .onDrag
        
        return view
    }()
  
    private lazy var tableController: TableController = {
        let controller = TableController(tableView: tableView)
        controller.delegate = self
        return controller
    }()
    
    private lazy var sendMessageView: SendMessgeView = {
        let view = SendMessgeView()
        view.delegate = self
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var imagePicker: PHPickerViewController = {
        var configuration = PHPickerConfiguration()
        configuration.selectionLimit = 0
        configuration.filter = .images
        
        let picker = PHPickerViewController(configuration: configuration)
        picker.delegate = self
        
        return picker
    }()

    // MARK: - Initializers

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    // MARK: Setup
    
    private func setup() {
        let viewController = self
        let interactor = MainScreenInteractor()
        let presenter = MainScreenPresenter()
        let router = MainScreenRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.output = presenter
        presenter.output = viewController
        router.viewController = viewController
    }

    // MARK: - View lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupView()
        setupConstraints()
        
        NotificationCenter.default.addObserver(self, 
                                               selector: #selector(keyboardWillShow),
                                               name: UIResponder.keyboardWillShowNotification,
                                               object: nil)
        NotificationCenter.default.addObserver(self, 
                                               selector: #selector(keyboardWillHide),
                                               name: UIResponder.keyboardWillHideNotification,
                                               object: nil)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    private func setupView() {
        view.addSubview(tableView)
        view.addSubview(sendMessageView)
    }
    
    private func setupConstraints() {
        
        let guide = view.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: guide.topAnchor),
            tableView.rightAnchor.constraint(equalTo: guide.rightAnchor),
            tableView.leftAnchor.constraint(equalTo: guide.leftAnchor),
            
            sendMessageView.topAnchor.constraint(equalTo: tableView.bottomAnchor),
            sendMessageView.leftAnchor.constraint(equalTo: guide.leftAnchor),
            sendMessageView.rightAnchor.constraint(equalTo: guide.rightAnchor),
        ])
        
        sendViewBottomConstraint = sendMessageView.bottomAnchor.constraint(equalTo: guide.bottomAnchor)
        sendViewBottomConstraint?.isActive = true
    }
    
    @objc func keyboardWillShow(notification: Notification) {
        guard let userInfo = notification.userInfo,
              let keyboardFrame = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect else { return }
        let animationDuration = userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as? TimeInterval ?? Const.defaultAnimationTime
        let keyboardHeight = (keyboardFrame.height) * -1
        sendViewBottomConstraint?.constant = keyboardHeight
        UIView.animate(withDuration: animationDuration) {
             self.view.layoutIfNeeded()
         }
    }

    @objc func keyboardWillHide(notification: Notification) {
        sendViewBottomConstraint?.constant = 0
        guard let userInfo = notification.userInfo else { return }
        let animationDuration = userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as? TimeInterval ?? Const.defaultAnimationTime
        UIView.animate(withDuration: animationDuration) {
             self.view.layoutIfNeeded()
         }
    }
}


// MARK: - MainScreenDisplayLogic

extension MainScreenViewController: MainScreenDisplayLogic {
    func loadedMessage(_ message: MessageViewModel) {
        tableController.addMessage(message)
    }
    
    func loadedMessages(_ data: [MessageViewModel]) {
        tableController.addMessages(data)
    }
    
    func deleteMessage(_ message: MessageViewModel) {
        tableController.deleteMessage(message)
    }
}

extension MainScreenViewController: TableControllerDelegate {
    func deleteMessage(viewModel: MessageViewModel) {
        interactor.deleteMessage(message: viewModel.dataModel)
    }
    
    func didTapOnCell() {
        view.endEditing(true)
    }
    
    func loadData() {
        interactor.loadData()
    }
}

extension MainScreenViewController: SendMessgeViewDelegate {
    func didTapAddImage() {
        present(imagePicker, animated: true)
    }
    
    func didTapSend(message: String) {
        guard !message.isEmpty else { return }
        interactor.sendMessage(message,images: selectedImages)
    }
}

extension MainScreenViewController: PHPickerViewControllerDelegate {
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
          dismiss(animated: true, completion: nil)
          
        selectedImages.removeAll()
        let itemProviders = results.map(\.itemProvider)
        
        for itemProvider in itemProviders {
              if itemProvider.canLoadObject(ofClass: UIImage.self) {
                  itemProvider.loadObject(ofClass: UIImage.self) { [weak self] image, error in
                      if let image = image as? UIImage {
                          DispatchQueue.main.async {
                              self?.selectedImages.append(image)
                          }
                      }
                  }
              }
          }
      }
}
