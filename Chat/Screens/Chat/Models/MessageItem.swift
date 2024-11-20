//
//  MessageItem.swift
//  Chat
//
//  Created by Emre Aşcı on 6.11.2024.
//


import Foundation
import SwiftUI

struct MessageItem: Identifiable {
    let id = UUID().uuidString
    let text: String
    let direction: MessageDirection
    
    static let sentPlaceholder = MessageItem(text: "emre", direction: .sent)
    static let receivedPlaceholder = MessageItem(text: "aşcı", direction: .received)
    
    
    var alignment: Alignment{
        return direction == .received ? .leading : .trailing
    }
    
    var horizontalAlignmnet: HorizontalAlignment{
        return direction == .received ? .leading : .trailing
    }
    
    
    var backgroundColor: Color{
        return direction == .sent ? .green.opacity(0.5) : .red.opacity(0.5)
    }
        
}



extension String{
    static let type = "type"
    static let timeStamp  = "timeStamp"
    static let ownerUid = "ownerUid"
    
}



