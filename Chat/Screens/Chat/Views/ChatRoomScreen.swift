//
//  ChatRoomScreen.swift
//  Chat
//
//  Created by Emre Aşcı on 5.11.2024.
//

import SwiftUI

struct ChatRoomScreen: View {
    var body: some View {
        
        
        ScrollView {
            LazyVStack {
                ForEach(0..<10) { _ in
                    Text("PLACEHOLDER")
                        .font(.largeTitle)
                        .bold()
                        .frame(maxWidth: .infinity)
                        .frame(height: 200)
                        .background(Color.gray.opacity(0.1))
                    
                }
            }
            
            
        }
        
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
                Text("USER")
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
        ChatRoomScreen()
    }
    
}
