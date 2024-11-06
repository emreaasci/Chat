//
//  AuthScreenModel.swift
//  Chat
//
//  Created by Emre Aşcı on 6.11.2024.
//

import Foundation


final class AuthScreenModel: ObservableObject {
    
    
    @Published var isLoading = false
    @Published var email = ""
    @Published var password = ""
    @Published var username = ""
    
    
    var disableLoginButton: Bool {
        return email.isEmpty || password.isEmpty || isLoading
    }
    
    var disableSignupButton: Bool {
        return username.isEmpty || email.isEmpty || password.isEmpty || isLoading
    }
    
    
    
}
