//
//  ChatPartnerRowView.swift
//  Chat
//
//  Created by Emre Aşcı on 7.11.2024.
//

import SwiftUI

struct ChatPartnerRowView: View {
    
    let user: UserItems
    
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
        }
        
        
    }
}

#Preview {
    ChatPartnerRowView(user: .placeHolder)
}
