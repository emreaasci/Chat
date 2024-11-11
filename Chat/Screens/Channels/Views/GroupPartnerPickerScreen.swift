//
//  AddGroupChatPartnersScreen.swift
//  Chat
//
//  Created by Emre Aşcı on 8.11.2024.
//


import Foundation
import SwiftUI

struct GroupPartnerPickerScreen: View {
    
    @ObservedObject var viewModel: ChatPartnerPickerViewModel
    @State private var searchText: String = ""
    
    var body: some View {
        List {
            if(viewModel.showSelectedUsers) {
                Text("Users Selected")
                
            }
            
            Section {
                ForEach([UserItems.placeHolder]){ item in
                    Button {
                        viewModel.handleItemSelection(item)
                    } label: {
                        chatPartnerRowView(.placeHolder)
                    }
                    
                }
            }
        }
        
        .animation(.easeInOut,value: viewModel.showSelectedUsers)
        .searchable(
            text: $searchText,
                placement: .navigationBarDrawer(displayMode: .always),
                prompt: "search name or phone number"
        )
    }
    
    
    private func chatPartnerRowView(_ user: UserItems) -> some View {
        
        ChatPartnerRowView(user: .placeHolder){
            Spacer()
            let isSelected = viewModel.isUserSelected(user)
            let imageName = isSelected ? "checkmark.circle.fill" : "circle"
            let foregroundStyle = isSelected ? Color.blue : Color(.systemGray3)
            Image(systemName: imageName)
                .foregroundStyle(foregroundStyle)
                .imageScale(.large)
        }
    }
}

#Preview {
    NavigationStack {
        GroupPartnerPickerScreen(viewModel: ChatPartnerPickerViewModel())
    }
}
