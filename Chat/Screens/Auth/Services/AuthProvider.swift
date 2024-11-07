//
//  AuthProvider.swift
//  Chat
//
//  Created by Emre Aşcı on 7.11.2024.
//

import Foundation
import Combine
import FirebaseAuth
import FirebaseDatabase


enum AuthState {
    case pending,loggedIn(UserItems),loggedOut
}


protocol AuthProvider {
    static var shared: AuthProvider { get }
    var authState: CurrentValueSubject<AuthState, Never> { get }
    func autoLogin() async
    func login(with email: String, and password: String) async throws
    func createAccount(for usarname: String,with email: String, and password: String) async throws
    func logout() async throws
}


enum AuthError : Error {
    case accountCreationFailed(_ description: String)
    case failedToSaveUserInfo(_ description: String)
}

extension AuthError : LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .accountCreationFailed(let description):
            return description
        case .failedToSaveUserInfo(let description):
            return description
        }
    }
}



final class AuthManager: AuthProvider {
    
    private init () {
        Task { await
            autoLogin()
        }
    }
    
    static let shared:  AuthProvider = AuthManager()
    var authState = CurrentValueSubject<AuthState, Never>(.pending)
    
    
    func autoLogin() async {
        if Auth.auth().currentUser == nil {
            authState.send(.loggedOut)
        } else {
            
            fetchCurrentUserInfo()
        }
    }
    
    func login(with email: String, and password: String) async throws {
        
    }
    
    func createAccount(for usarname: String, with email: String, and password: String) async throws {
        do {
            let authResult = try await Auth.auth().createUser(withEmail: email, password: password)
            let uid = authResult.user.uid
            let newUser = UserItems(uid: uid, username: usarname, email: email)
            try await saveUserInfoDatabase(user: newUser)
            
            self.authState.send(.loggedIn(newUser))
            
            
        } catch {
            print("Failed create account: \(error.localizedDescription)")
            throw AuthError.accountCreationFailed(error.localizedDescription)
        }
        
    }
    
    func logout() async throws {
        
    }
}


extension AuthManager{
    private func saveUserInfoDatabase(user: UserItems) async throws {
        do {
            let userDirectory = ["uid" : user.id, "username" : user.username, "email" : user.email]
            try await Database.database().reference().child("users").child(user.uid).setValue(userDirectory)
            
        } catch {
            print("Failed to save user info to database: \(error.localizedDescription)")
            throw AuthError.failedToSaveUserInfo(error.localizedDescription)
        }
        
    }
    
    private func fetchCurrentUserInfo() {
        guard let currentUid = Auth.auth().currentUser?.uid else { return }
        Database.database().reference().child("users").child(currentUid).observe(.value) { snapshot in
            guard let userDict = snapshot.value as? [String: Any] else { return }
            let loggedInUser = UserItems(dictionary: userDict)
            self.authState.send(.loggedIn(loggedInUser))
            
            print("\(loggedInUser.username) logged in")
        } withCancel: { error in
            print("Failed current user info fetch")
        }
        
        
    }
}


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


