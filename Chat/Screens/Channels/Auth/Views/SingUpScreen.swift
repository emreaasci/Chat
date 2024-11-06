//
//  SingUpScreen.swift
//  Chat
//
//  Created by Emre Aşcı on 6.11.2024.
//

import SwiftUI

struct SingUpScreen: View {
    
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        VStack {
            Spacer()
            AuthHeaderView()
            AuthTextField(text: .constant(""), type: .email)
            
            
            let userNameType = AuthTextField.InputType.custom("Username", "at")
            AuthTextField(text: .constant(""), type: userNameType)
            AuthTextField(text: .constant(""), type: .password)
            
            AuthButton(title: "Create Account") {
                
            }
            
            
            
            
            Spacer()
            
            backButton()
        }
        
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        
        .background(LinearGradient(colors: [.red, .red.opacity(0.5), .yellow], startPoint: .top, endPoint: .bottom))
        .navigationBarBackButtonHidden()
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
    SingUpScreen()
}

