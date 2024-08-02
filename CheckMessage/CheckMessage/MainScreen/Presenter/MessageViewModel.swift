//
//  MessageViewModel.swift
//  CheckMessage
//
//  Created by Dmytro on 31.07.2024.
//

import UIKit

struct MessageViewModel {
    let dataModel: MessageDataModel

    var userId: String {
        dataModel.userId
    }
    
    var message: String {
        dataModel.message
    }
    
    var messageId: String {
        dataModel.messageId
    }
    
    

    var image: UIImage? {
        guard let url = URL(string: dataModel.imageUrl ?? "") else { return nil }
        guard let imageData = try? Data(contentsOf: url) else { return nil }
        return UIImage(data: imageData)
    }
}
