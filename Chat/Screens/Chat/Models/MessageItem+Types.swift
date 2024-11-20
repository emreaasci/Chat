//
//  MessageItem+Types.swift
//  Chat
//
//  Created by Emre Aşcı on 19.11.2024.
//

import Foundation



enum AdminMessageType: String {
    case channelCreation
    case memberAdded
    case memberLeft
    case channelNameChanged
}

enum MessageDirection{
    case sent, received
    
    
    static var random: MessageDirection{
        return [MessageDirection.sent, .received].randomElement() ?? .sent
    }
    
}
