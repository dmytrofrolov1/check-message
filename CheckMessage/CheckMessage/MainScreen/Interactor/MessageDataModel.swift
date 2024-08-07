//
//  MessageDataModel.swift
//  CheckMessage
//
//  Created by Dmytro on 31.07.2024.
//

import UIKit

struct MessageDataModel {
    let messageId: String
    let userId: String
    let message: String
    let avatarImageUrl: String?
    //supposed to be ulrs
    let messageImages: [UIImage]?
}
