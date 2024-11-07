//
//  AuthTextField.swift
//  Chat
//
//  Created by Emre Aşcı on 6.11.2024.
//

import SwiftUI

struct AuthTextField: View {
    @Binding var text: String
    let type: InputType
    
    var body: some View {
        HStack {
            Image(systemName: type.imageName)
                .fontWeight(.semibold)
                .frame(width: 30)
            
            switch type {
            case .password:
                SecureField(type.placeHolder, text: $text)
                
            default:
                TextField(type.placeHolder, text: $text)
                    .keyboardType(type.keyboardType)
                
            }
        }
        
        .foregroundStyle(.black)
        .padding()
        .background(Color.white.opacity(0.3))
    
        .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
        .padding(.horizontal, 30)
    }
}

extension AuthTextField {
    enum InputType {
        case email
        case password
        case custom (_ placeholder : String, _ icon_name : String)
        
        
        var placeHolder: String {
            switch self {
            case .email:
                return "E-mail"
                
            case .password:
                return "Password"
                
                
            case .custom(let placeholder, _):
                return placeholder
                
            }
        }
        
        var imageName: String {
            switch self {
            case .email:
                return "envelope"
                
            case .password:
                return "lock"
                
                
            case .custom(_, let icon_name):
                return icon_name
            }
        }
        
        
        var keyboardType: UIKeyboardType {
            switch self {
            case .email:
                return .emailAddress
                
            default:
                return .default
            }
        }
    }
    
    
    #Preview {
        ZStack {
            Color.red
            VStack {
                AuthTextField(text: .constant(""), type: .email)
                AuthTextField(text: .constant(""), type: .password)
                AuthTextField(text: .constant(""), type: .custom("Birthday", "birthday.cake"))
            }
            
        }
        
    }
}
