//
//  GroupPartnerPickerScreen.swift
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
                SelectedChatPartnerView(users: viewModel.selectedChatPartners) {user in
                    viewModel.handleItemSelection(user)
                }
                
            }
            
            Section {
                ForEach(UserItems.placeHolders){ item in
                    Button {
                        viewModel.handleItemSelection(item)
                    } label: {
                        chatPartnerRowView(item)
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
        
        .toolbar{
            titleView()
            traillingNavItem()
        }
    }
    

    
    private func chatPartnerRowView(_ user: UserItems) -> some View {
        
        ChatPartnerRowView(user: user){
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


extension GroupPartnerPickerScreen {
    @ToolbarContentBuilder
    private func titleView() -> some ToolbarContent {
        ToolbarItem(placement: .principal) {
            VStack {
                Text("Add Participants")
                    .bold()
                
                let count = viewModel.selectedChatPartners.count
                let maxCount = ChannelCotants.maxGroupParticipants
                
                Text("\(count)/\(maxCount)")
                    .font(.footnote)
                    .foregroundStyle(.gray)
            }
        }
    }
    @ToolbarContentBuilder
    private func traillingNavItem() -> some ToolbarContent {
        ToolbarItem(placement: .topBarTrailing) {
            Button("Next"){
                viewModel.navStack.append(.setUpGroupChat)
            }
            .bold()
            .disabled(viewModel.disableNextButton)
        }
    }
    
}


#Preview {
    NavigationStack {
        GroupPartnerPickerScreen(viewModel: ChatPartnerPickerViewModel())
    }
}
