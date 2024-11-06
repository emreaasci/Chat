//
//  LoginScreen.swift
//  Chat
//
//  Created by Emre Aşcı on 6.11.2024.
//

import SwiftUI

struct LoginScreen: View {
    
    @StateObject private var authScreenModel = AuthScreenModel()
    
    
    var body: some View {
        NavigationStack {
            VStack {
                Spacer()
                AuthHeaderView()
                
                
                
                
                AuthTextField(text: .constant(""), type: .email)
                AuthTextField(text: .constant(""), type: .password)
                
                AuthButton(title: "LOGIN") {
                    
                }
                .disabled(authScreenModel.disableLoginButton)
                
                Spacer()
                
                singUpButton()
                    .padding(.bottom, 30)
            }
            
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(LinearGradient(colors: [.red, .red.opacity(0.5), .yellow], startPoint: .top, endPoint: .bottom))
            .ignoresSafeArea()
        }
    }
    
    private func singUpButton() -> some View {
    
        NavigationLink {
            SingUpScreen()
        } label : {
            HStack {
                Text("SIGN UP")
            }
            .foregroundStyle(.black)
            
        }
    }
}




#Preview {
    LoginScreen()
}
