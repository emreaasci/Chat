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
    case emailLoginFailed(_ description: String)
}

extension AuthError : LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .accountCreationFailed(let description):
            return description
        case .failedToSaveUserInfo(let description):
            return description
        case .emailLoginFailed(let description):
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
        
        do {
            let authResult = try await Auth.auth().signIn(withEmail: email, password: password)
            fetchCurrentUserInfo()
            print("Successful login \(authResult.user.email ?? "")")
            
        } catch {
            
            print("Failed login: \(email)")
            throw AuthError.emailLoginFailed(error.localizedDescription)
        }
        
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
        
        do {
            
            try Auth.auth().signOut()
            authState.send(.loggedOut)
            print("Successfuly logged out!")
        } catch {
            
            print("Failed logged out from account: \(error.localizedDescription)")
            
        }
        
        
        
    }
    
    
    
}


extension AuthManager{
    private func saveUserInfoDatabase(user: UserItems) async throws {
        do {
            let userDirectory: [String: Any] = [.uid : user.id, .username : user.username, .email: user.email]
            try await FirebaseConstants.UserRef.child(user.uid).setValue(userDirectory)
            
        } catch {
            print("Failed to save user info to database: \(error.localizedDescription)")
            throw AuthError.failedToSaveUserInfo(error.localizedDescription)
        }
        
    }
    
    private func fetchCurrentUserInfo() {
        guard let currentUid = Auth.auth().currentUser?.uid else { return }
        FirebaseConstants.UserRef.child(currentUid).observe(.value) { snapshot in
            guard let userDict = snapshot.value as? [String: Any] else { return }
            let loggedInUser = UserItems(dictionary: userDict)
            self.authState.send(.loggedIn(loggedInUser))
            
            print("\(loggedInUser.username) logged in")
        } withCancel: { error in
            print("Failed current user info fetch")
        }
        
        
    }
}




