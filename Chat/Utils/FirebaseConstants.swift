//
//  FirebaseConstants.swift
//  Chat
//
//  Created by Emre Aşcı on 7.11.2024.
//



import Foundation
import Firebase
import FirebaseStorage

enum FirebaseConstants {
    private static let DatabaseRef = Database.database().reference()
    static let UserRef = DatabaseRef.child("users")
    static let ChannelsRef = DatabaseRef.child("channels")
    static let MessagesRef = DatabaseRef.child("messages-referance")
    static let UserChannelsRef = DatabaseRef.child("users-channels")
    static let UserDirectChannels = DatabaseRef.child("user-direct-channels")
    
    
    
}


//extension String {
//    static let id = "id"
//    
//    static let name = "name"
//    static let lastMessage = "lastMessage"
//    static let lastMessageTimeStamp = "lastMessageTimeStamp"
//    static let memberCount = "memberCount"
//    static let adminUids = "adminUids"
//    static let membersUids = "memberUids"
//    static let thumbnailUrl = "thumbnailUrl"
//}
