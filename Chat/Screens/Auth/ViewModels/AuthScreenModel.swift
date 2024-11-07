//
//  AuthScreenModel.swift
//  Chat
//
//  Created by Emre Aşcı on 6.11.2024.
//

import Foundation


@MainActor
final class AuthScreenModel: ObservableObject {
    
    
    @Published var isLoading = false
    @Published var email = ""
    @Published var password = ""
    @Published var username = ""
    
    @Published var errorState: (showError: Bool, errorMessage: String) = (false, "ERROR!")
    
    
    var disableLoginButton: Bool {
        return email.isEmpty || password.isEmpty || isLoading
    }
    
    var disableSignupButton: Bool {
        return username.isEmpty || email.isEmpty || password.isEmpty || isLoading
    }
    
    func handleSignup() async {
        isLoading = true
        
        do{
            try await AuthManager.shared.createAccount(for: username, with: email, and: password)
        } catch {
            errorState.errorMessage = "Failed create accort \(error.localizedDescription)"
            errorState.showError = true
            isLoading = false
        }
        
    }
    
    func handlelogin() async {
        isLoading = true
        
        do{
            try await AuthManager.shared.login(with: email, and: password)
        } catch {
            errorState.errorMessage = "Failed login \(error.localizedDescription)"
            errorState.showError = true
            isLoading = false
        }
    }
    
    
    
}
