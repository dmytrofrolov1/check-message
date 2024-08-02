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
    
    var messageImages: [UIImage]? {
        dataModel.messageImages
    }

    var image: UIImage? {
        guard let url = URL(string: dataModel.avatarImageUrl ?? "") else { return nil }
        guard let imageData = try? Data(contentsOf: url) else { return nil }
        return UIImage(data: imageData)
    }
}
