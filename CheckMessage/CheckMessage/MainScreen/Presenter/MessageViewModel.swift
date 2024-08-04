//
//  MessageViewModel.swift
//  CheckMessage
//
//  Created by Dmytro on 31.07.2024.
//

import UIKit

enum MessageType {
    case text
    case images
}

enum MessageDirection {
    case outgoing
    case incoming
}

struct MessageViewModel {
    let dataModel: MessageDataModel

    var type: MessageType {
        return messageImages?.isEmpty ?? true ? .text : .images
    }
    
    var direction: MessageDirection {
        return userId == GlobalConst.userId ? .outgoing : .incoming
    }
    
    var userId: String {
        dataModel.userId
    }
    
    var message: String {
        dataModel.message
    }
    
    var messageId: String {
        dataModel.messageId
    }
    
    var messageImages: [UIImage]? {
        dataModel.messageImages
    }

    var image: UIImage? {
        guard let url = URL(string: dataModel.avatarImageUrl ?? "") else { return nil }
        guard let imageData = try? Data(contentsOf: url) else { return nil }
        return UIImage(data: imageData)
    }
}
