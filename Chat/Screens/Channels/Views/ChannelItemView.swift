//
//  ChannelItemView.swift
//  Chat
//
//  Created by Emre Aşcı on 5.11.2024.
//

import SwiftUI

struct ChannelItemView: View {
    var body: some View {
        HStack(alignment: .top, spacing: 10) {
            Circle()
                .frame(width: 60, height:  60)
            
            VStack(alignment: .leading, spacing: 3) {
                titleTextView()
                lastMessageTextView()
            }
        }
    }
    
    private func titleTextView() -> some View {
        HStack {
            Text("Username was here")
                .lineLimit(1)
                .bold()
            
            Spacer()
            
            Text("15:70")
                .foregroundStyle(.gray)
                .font(.system(size: 15))
                
            
        }
    }
    
    private func lastMessageTextView() -> some View {
        Text("Last message")
            .foregroundStyle(.gray)
            .font(.system(size: 16))
            .lineLimit(2)
    }
}

#Preview {
    ChannelItemView()
}
