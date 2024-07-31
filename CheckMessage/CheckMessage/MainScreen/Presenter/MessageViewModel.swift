//
//  MessageViewModel.swift
//  CheckMessage
//
//  Created by Dmytro on 31.07.2024.
//

import Foundation

struct MessageViewModel {
    private let dataModel: MessageDataModel
    
    var message: String {
        return dataModel.message
    }
    
    init(data: MessageDataModel) {
        self.dataModel = data
    }
}
