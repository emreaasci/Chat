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
