//
//  MainScreenInteractor.swift
//  CheckMessage
//
//  Created by Dmytro on 29.07.2024.
//  Copyright (c) 2024 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

class MainScreenInteractor {
    private let messagesDataSource = TestMessgesRepository()
    var output: MainScreenPresentationLogic?

}


// MARK: - MainScreenBusinessLogic

extension MainScreenInteractor: MainScreenBusinessLogic {
    func sendMessage(_ message: String, images: [UIImage]?) {
        let messageDataModel = messagesDataSource.sendMessage(message: message, images: images)
        output?.loadedData(messageDataModel)
    }
    
    func deleteMessage(message: MessageDataModel) {
        //should interact with external api
        output?.deleteMessage(message)
    }
    
    
    func loadData() {
        let messages = messagesDataSource.loadMessages()
        output?.loadedData(messages)
    }

}

