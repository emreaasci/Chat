//
//  ChatRoomScreen.swift
//  Chat
//
//  Created by Emre Aşcı on 5.11.2024.
//

import SwiftUI

struct ChatRoomScreen: View {
    let channel: ChannelItem
    
    var body: some View {
        
        
        MessageListView()
            
            .toolbar(.hidden, for: .tabBar)
            .toolbar {
                leadingNavItems()
                trailingNavItems()
            }
            
            .safeAreaInset(edge: .bottom) {
                TextInputArea()
            }
        }
}


extension ChatRoomScreen {
    
    @ToolbarContentBuilder
    private func leadingNavItems() -> some ToolbarContent {
        ToolbarItem(placement: .topBarLeading) {
            HStack {
                Circle()
                    .frame(width: 30, height: 35)
                Text(channel.title)
                    .bold()
            }
            
            
        }
        
    }
    
    
    @ToolbarContentBuilder
    private func trailingNavItems() -> some ToolbarContent {
        ToolbarItemGroup(placement: .topBarTrailing) {
            Button {
                    
            } label: {
                Image(systemName: "video")
            }
            
            Button {
                    
            } label: {
                Image(systemName: "phone")
            }
        }
        
    }
    
    
}


#Preview {
    NavigationStack {
        ChatRoomScreen(channel: .placeholder)
    }
    
}
