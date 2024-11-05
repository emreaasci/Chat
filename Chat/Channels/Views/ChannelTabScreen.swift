//
//  ChannelTabScreen.swift
//  Chat
//
//  Created by Emre Aşcı on 5.11.2024.
//


import SwiftUI

struct ChannelTabScreen: View {
    @State private var searchText: String = ""
    
    
    var body: some View {
        NavigationStack{
            List {
                archivedButton()
            }
            .navigationTitle("Chats")
            .searchable(text: $searchText)
            .listStyle(.plain)
            .toolbar{
                loadingNavItems()
                trailingNavItems()
            }
            
            
        }
    }
    
}


extension ChannelTabScreen {
    @ToolbarContentBuilder
    private func loadingNavItems() -> some ToolbarContent {
        ToolbarItem(placement: .topBarLeading) {
            Menu{
                Button{
                    
                }
                
                label : {
                    Label("Select Chats", systemImage: "checkmark.circle")
                }
                
            }
            label : {
                Image(systemName: "ellipsis.circle")
            }
        }
    }
    
    @ToolbarContentBuilder
    private func trailingNavItems() -> some ToolbarContent {
        ToolbarItemGroup(placement: .topBarTrailing)
        {
            aiButton()
            newChatButton()
            cameraButton()
        }
        
    }
    
    private func aiButton() -> some View {
        Button {
            
        } label: {
            Image(systemName: "circle")
        }
    }
    
    private func newChatButton() -> some View {
        Button {
            
        } label: {
            Image(systemName: "plus")
        }
    }
    
    private func cameraButton() -> some View {
        Button {
            
        } label: {
            Image(systemName: "camera")
        }
    }
    
    private func archivedButton() -> some View {
        Button {
            
        } label: {
            Label("Archived", systemImage: "archivebox.fill")
                .bold()
                .padding()
                .foregroundColor(.gray)
        }
        
    }
    
}


#Preview {
    ChannelTabScreen()
}
