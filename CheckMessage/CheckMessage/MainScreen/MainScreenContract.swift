//
//  MainScreenContract.swift
//  CheckMessage
//
//  Created by Dmytro on 29.07.2024.
//  Copyright (c) 2024 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

protocol MainScreenBusinessLogic {
    func loadData()
    func sendMessage(_ message: String)
}

protocol MainScreenPresentationLogic {
    func loadedData(_ data: [MessageDataModel])
    func loadedData(_ message: MessageDataModel)
}

protocol MainScreenDisplayLogic: AnyObject {
    func loadedMessages(_ data: [MessageViewModel])
    func loadedMessage(_ message: MessageViewModel)
}

protocol MainScreenRouterProtocol {

}
