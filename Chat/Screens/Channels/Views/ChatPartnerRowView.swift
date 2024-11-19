//
//  ChatPartnerRowView.swift
//  Chat
//
//  Created by Emre Aşcı on 7.11.2024.
//

import SwiftUI

struct ChatPartnerRowView<Content: View>: View {
    
    let user: UserItem
    private var trailingItem: Content
    
    
    init (user: UserItem, @ViewBuilder trailingItem: () -> Content = {EmptyView()}) {
        self.user = user
        self.trailingItem = trailingItem()
    }
    
    var body: some View {
        
        HStack {
            Circle()
                .frame(width: 40,height: 40)
            VStack(alignment: .leading) {
                
                Text(user.username)
                    .bold()
                    .foregroundStyle(.black)
                
                Text(user.bioUnwrapped ?? "hey dude")
                    .font(.caption)
                    .foregroundStyle(.gray)
               
            }
            
            trailingItem
            
        }
        
        
        
        
    }
}


#Preview {
    ChatPartnerRowView(user: .placeholder) {
        Image(systemName: "xmark")
    }
}
