//
//  MainScreenViewController.swift
//  CheckMessage
//
//  Created by Dmytro on 29.07.2024.
//  Copyright (c) 2024 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

class MainScreenViewController: UIViewController {

    var interactor: MainScreenBusinessLogic!
    var router: MainScreenRouterProtocol!

    private lazy var tableView: UITableView = {
        let view = UITableView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var textField: UITextField = {
        let field = UITextField()
        field.translatesAutoresizingMaskIntoConstraints = false
        
        return field
    }()

    private lazy var tableController: TableController = {
        let controller = TableController(tableView: tableView)
        return controller
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
        interactor.loadData()
    }
    
    private func setupView() {
        view.addSubview(tableView)
    }
    
    private func setupConstraints() {
        
        let guide = view.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: guide.topAnchor),
            tableView.rightAnchor.constraint(equalTo: guide.rightAnchor),
            tableView.bottomAnchor.constraint(equalTo: guide.bottomAnchor),
            tableView.leftAnchor.constraint(equalTo: guide.leftAnchor)
        ])
        
    }

}


// MARK: - MainScreenDisplayLogic

extension MainScreenViewController: MainScreenDisplayLogic {
    func loadedMessages(_ data: [MessageViewModel]) {
        tableController.addMessages(data)
    }
    // MARK: - Display logic
}

extension MainScreenViewController: TableControllerDelegate {
    func loadData() {
        print("load data in MainScreenViewController")
    }
}
