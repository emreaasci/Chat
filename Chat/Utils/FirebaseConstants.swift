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
}
