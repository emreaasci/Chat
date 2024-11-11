//
//  UserItem.swift
//  Chat
//
//  Created by Emre Aşcı on 7.11.2024.
//

import Foundation

struct UserItems: Identifiable, Hashable, Decodable {
    let uid: String
    let username: String
    let email: String
    var bio: String? = nil
    var profileImageUrl: String? = nil
    
    
    var id: String {
        return uid
    }
    
    var bioUnwrapped: String? {
        return bio ?? "HEY THERE!"
    }
    
    
    static let placeHolder = UserItems(uid: "1", username: "emres", email: "emre@gmail.com")
    
    static let placeHolders: [UserItems] = [
        
        UserItems(uid: "1", username: "Emre", email: "emre1@gmail.com", bio: "aaaaaaaaaaa"),
        UserItems(uid: "2", username: "Fatih", email: "emre2@gmail.com", bio: "bbbbbbbbbb"),
        UserItems(uid: "3", username: "Taco", email: "emre3@gmail.com", bio: "cccccccccccc"),
        UserItems(uid: "4", username: "Yavuz", email: "emre4@gmail.com", bio: "ddddddddddd"),
        UserItems(uid: "5", username: "Ahmet", email: "emre5@gmail.com", bio: "eeeeeeeeeee"),
        UserItems(uid: "6", username: "Mehmet", email: "emre6@gmail.com", bio: "fffffffffff"),
        UserItems(uid: "7", username: "Selim", email: "emre7@gmail.com", bio: "gggggggggg"),
        UserItems(uid: "8", username: "ICARDI", email: "emre8@gmail.com", bio: "hhhhhhhhhh"),
        UserItems(uid: "9", username: "OSHIMEN", email: "emre9@gmail.com", bio: "iiiiiiiiii"),
        UserItems(uid: "10", username: "SARA", email: "emre10@gmail.com", bio: "yyyyyyyyyyyy"),
        
    ]
    
}


extension UserItems {
    init (dictionary: [String: Any]) {
        self.uid = dictionary["uid"] as? String ?? ""
        self.email = dictionary["email"] as? String ?? ""
        self.username = dictionary["username"] as? String ?? ""
        self.bio = dictionary["bio"] as? String ?? nil
        self.profileImageUrl = dictionary["profileImageUrl"] as? String ?? nil
    }
}

extension String {
    static let uid = "uid"
    static let email = "email"
    static let username = "username"
    static let bio = "bio"
    static let profileImageUrl = "profileImageUrl"
}
