//
//  TestMessgesRepository.swift
//  CheckMessage
//
//  Created by Dmytro on 31.07.2024.
//

import Foundation

class TestMessgesRepository {
    private enum Const {
        static let clientImageName: String = "client"
        static let userImageName: String = "user"
    }
    
    var userImageUrl: String {
        guard let imageUrl = Bundle.main.url(forResource: Const.userImageName, withExtension: "png") else { return "" }
        return imageUrl.absoluteString
    }
    
    var clientImageUrl: String {
        guard let imageUrl = Bundle.main.url(forResource: Const.clientImageName, withExtension: "png") else { return "" }
        return imageUrl.absoluteString
    }
    
    func loadMessages() -> [MessageDataModel] {
        
        var messages = [MessageDataModel]()
        
        for _ in 0...10 {
            let userId = Int.random(in: 0...10) % 2 == 0 ? GlobalConst.userId : GlobalConst.clientId
            let messageId = UUID().uuidString
            let message = generateMessage()
            let imageUrl = userId == GlobalConst.userId ? userImageUrl : clientImageUrl
            
            messages.append(MessageDataModel(messageId: messageId, userId: userId, message: message, imageUrl: imageUrl))
        }
        
        return messages
    }
    
    
    let loremIpsumText = """
    Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.
    """

    func generateMessage() -> String {
        let words = loremIpsumText.split(separator: " ").map { String($0) }
        let randomWordCount = Int.random(in: 5...20)
        var messageWords = [String]()
        for _ in 0..<randomWordCount {
            let randomIndex = Int.random(in: 0..<words.count)
            messageWords.append(words[randomIndex])
        }
        let message = messageWords.joined(separator: " ")
        
        return message
    }
//    let messages = [
//        MessageDataModel(messageId: "1", userId: "12", message: "some message", data: nil ),
//        MessageDataModel(messageId: "2", userId: "12", message: "random", data: nil),
//        MessageDataModel(messageId: "3", userId: "12", message: "m", data: nil),
//        MessageDataModel(messageId: "4", userId: "12", message: "mess", data: nil),
//        MessageDataModel(messageId: "5", userId: "12", message: "aaaa", data: nil),
//        MessageDataModel(messageId: "6", userId: "12", message: "reter", data: nil),
//        MessageDataModel(messageId: "7", userId: "12", message: "sdfsd", data: nil),
//        MessageDataModel(messageId: "8", userId: "12", message: "sdf", data: nil),
//        MessageDataModel(messageId: "9", userId: "12", message: "sdfas", data: nil),
//        MessageDataModel(messageId: "10", userId: "12", message: "asfd", data: nil),
//    ]
}
