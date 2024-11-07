//
//  SingUpScreen.swift
//  Chat
//
//  Created by Emre Aşcı on 6.11.2024.
//

import SwiftUI

struct SingUpScreen: View {
    
    @Environment(\.dismiss) private var dismiss
    @ObservedObject var authScreenModel: AuthScreenModel
    
    var body: some View {
        VStack {
            Spacer()
            AuthHeaderView()
            AuthTextField(text: $authScreenModel.email, type: .email)
            
            
            let userNameType = AuthTextField.InputType.custom("Username", "at")
            AuthTextField(text: $authScreenModel.username, type: userNameType)
            AuthTextField(text: $authScreenModel.password, type: .password)
            
            AuthButton(title: "Create Account") {
                Task {
                    await authScreenModel.handleSignup()
                }
            }
            
            .disabled(authScreenModel.disableSignupButton)
            
            
            
            
            Spacer()
            
            backButton()
        }
        
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        
        .background(LinearGradient(colors: [.red, .red.opacity(0.5), .yellow], startPoint: .top, endPoint: .bottom))
        .navigationBarBackButtonHidden()
        
        .alert(isPresented: $authScreenModel.errorState.showError) {
            Alert(
                title: Text(authScreenModel.errorState.errorMessage),
                dismissButton: .default(Text("OK"))
            )
        }

    }
    
    private func backButton() -> some View {
        Button {
            dismiss()
            
        } label: {
            HStack {
                Text("LOGIN")
            }
            
            .foregroundStyle(.black)

        }
    }
}







#Preview {
    SingUpScreen(authScreenModel: AuthScreenModel())
}

