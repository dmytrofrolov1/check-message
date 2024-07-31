//
//  MainScreenInteractor.swift
//  CheckMessage
//
//  Created by Dmytro on 29.07.2024.
//  Copyright (c) 2024 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

class MainScreenInteractor {

    var output: MainScreenPresentationLogic?

}


// MARK: - MainScreenBusinessLogic

extension MainScreenInteractor: MainScreenBusinessLogic {
    func loadData() {
        let repos = TestMessgesRepository()
        let messages = repos.messages
        output?.loadedData(messages)
    }

    // MARK: - Business logic

}
