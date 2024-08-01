//
//  MainScreenPresenter.swift
//  CheckMessage
//
//  Created by Dmytro on 29.07.2024.
//  Copyright (c) 2024 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit


class MainScreenPresenter {

    weak var output: MainScreenDisplayLogic?

}


// MARK: - MainScreenPresentationLogic

extension MainScreenPresenter: MainScreenPresentationLogic {
    func loadedData(_ message: MessageDataModel) {
        let viewModel = MessageViewModel(data: message)
        output?.loadedMessage(viewModel)
    }
    
    func loadedData(_ data: [MessageDataModel]) {
        let viewModels = data.map({ MessageViewModel(data: $0) })
        output?.loadedMessages(viewModels)
    }

}
