//
//  UserItem.swift
//  Chat
//
//  Created by Emre Aşcı on 7.11.2024.
//

import Foundation

import Foundation

struct UserItem: Identifiable, Hashable, Decodable {
    let uid: String
    let username: String
    let email: String
    var bio: String? = nil
    var profileImageUrl: String? = nil
    
    var id: String {
        return uid
    }
    
    var bioUnwrapped: String {
        return bio ?? "Hey there! I am using WhatsApp."
    }
    
    static let placeholder = UserItem(uid: "1", username: "eMre", email: "emreaasci@gmail.com")
    
    static let placeholders: [UserItem] = [
        UserItem(uid: "1", username: "EMRE", email: "emrea@gmail.com"),
        UserItem(uid: "2", username: "OSIMHEN", email: "emreb@gmail.com", bio: "asdaddassd."),
        UserItem(uid: "3", username: "ICARDI", email: "emrec@gmail.com", bio: "Pdddsd"),
        UserItem(uid: "4", username: "SARA", email: "emred@gmail.com", bio: "Teasdadsdsaiast."),
        UserItem(uid: "5", username: "MERTENS", email: "emree@gmail.com", bio: "Loasdasdure."),
        UserItem(uid: "6", username: "TOREIRA", email: "emref@gmail.com", bio: "sdadddddddd."),
        UserItem(uid: "7", username: "DAVINSON", email: "emref@gmail.com"),
        UserItem(uid: "8", username: "YUNUS", email: "emreg@gmail.com", bio: "CocsadaSDasdasda"),
        UserItem(uid: "9", username: "BARIŞ", email: "emreh@gmail.com", bio: "Musaddadqwdrw"),
        UserItem(uid: "10", username: "MUSLERA", email: "emreı@gmail.com", bio: "Tsaqddqweqdqerw")
    ]

}

extension UserItem {
    init(dictionary: [String: Any]) {
        self.uid = dictionary[.uid] as? String ?? ""
        self.username = dictionary[.username] as? String ?? ""
        self.email = dictionary[.email] as? String ?? ""
        self.bio = dictionary[.bio] as? String? ?? nil
        self.profileImageUrl = dictionary[.profileImageUrl] as? String? ?? nil
    }
}

extension String {
    static let uid = "uid"
    static let username = "username"
    static let email = "email"
    static let bio = "bio"
    static let profileImageUrl = "profileImageUrl"
}
