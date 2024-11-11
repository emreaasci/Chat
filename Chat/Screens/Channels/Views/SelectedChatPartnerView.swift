//
//  SelectedChatPartnerView.swift
//  Chat
//
//  Created by Emre Aşcı on 8.11.2024.
//

import SwiftUI

struct SelectedChatPartnerView: View {
    let users: [UserItems]
    
    let onTabHandler: (_ user: UserItems) -> Void
    
    
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false){
            HStack {
                ForEach(users){item in
                    chatPartnerView(item)
                    
                }
            }
        }
    }
    
    
    private func chatPartnerView(_ user: UserItems) -> some View {
        
        VStack {
            Circle()
                .fill(.gray)
                .frame(width: 60,height: 60)
                .overlay(alignment: .topTrailing) {
                    cancelButton(user)
                }
            Text(user.username)
        }
        
        
    }
    
    private func cancelButton(_ user: UserItems) -> some View {
        Button {
            onTabHandler(user)
        } label: {
            Image(systemName: "xmark")
                .imageScale(.small)
                .foregroundStyle(.white)
                .fontWeight(.semibold)
                .padding(5)
                .background(Color(.systemGray2))
                .clipShape(Circle())
        }
    }
    
    
}

#Preview {
    SelectedChatPartnerView(users: UserItems.placeHolders) { user in
        
        
        
        
    }
}
