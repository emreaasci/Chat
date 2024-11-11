//
//  ChatPartnerPickerScreen.swift
//  Chat
//
//  Created by Emre Aşcı on 7.11.2024.
//

import SwiftUI

struct ChatPartnerPickerScreen: View {
    
    @State private var searchText: String = ""
    @Environment(\.dismiss) private var dismiss
    
    @StateObject private var viewModel = ChatPartnerPickerViewModel()
    
    var body: some View {
        NavigationStack(path: $viewModel.navStack) {
            List {
                ForEach(ChatPartnerpickerOption.allCases) { item in
                    HeaderItemView(item: item)
                        .onTapGesture {
                            viewModel.navStack.append(.groupPartnerPicker)
                        }
                        .foregroundStyle(Color.black)
                    
                        
                }
                
                Section {
                    ForEach(0..<10){_ in
                        ChatPartnerRowView(user: .placeHolder)
                    }
                    
                } header: {
                    Text("contact list")
                        //.textCase(nil)
                        .bold()
                }
                
            }
            .searchable(
                text: $searchText,
                    placement: .navigationBarDrawer(displayMode: .always),
                    prompt: "search name or phone number"
            )
            
            .navigationTitle("New Chat")
            .navigationDestination(for: ChannelCreationRoute.self) { route in
                destinationView(for: route)
                
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                trailingNavItem()
            }
            
        }
    }
}

extension ChatPartnerPickerScreen {
    @ViewBuilder
    private func destinationView(for route: ChannelCreationRoute) -> some View {
        switch route {
            case .groupPartnerPicker:
            GroupPartnerPickerScreen(viewModel: viewModel)
            
            case .setUpGroupChat:
                NewGroupSetUpScreen(viewModel: ChatPartnerPickerViewModel())


        }
        
    }
}



extension ChatPartnerPickerScreen{
    
    @ToolbarContentBuilder
    private func trailingNavItem() -> some ToolbarContent {
        
        ToolbarItem(placement: .topBarTrailing) {
            cancelButton()
        }
        
    }
    
    
    private func cancelButton() -> some View {
        Button {
            dismiss()
        } label: {
            Image(systemName: "xmark")
                .font(.footnote)
                .bold()
                .foregroundStyle(.gray)
                .padding(8)
                .background(Color(.systemGray5))
                .clipShape(Circle())
        }
    }
    
    
    private struct HeaderItemView: View {
        let item: ChatPartnerpickerOption
        
        var body: some View {
            
            Button {
                
            } label: {
                buttonBody()
            }
            
        }
        
        private func buttonBody() -> some View {
            HStack {
                Image(systemName: item.ımageName)
                    .foregroundStyle(Color.black)
                    .font(.footnote)
                    .frame(width: 40, height: 40)
                    .background(Color(.systemGray6))
                    .clipShape(Circle())
                
                
                Text(item.title)
            }
        }
        
        
    }
}


enum ChatPartnerpickerOption: String, CaseIterable, Identifiable {
    case newGroup = "New Group"
    case newContact = "New Contact"
    case newCommunity = "New Community"
    
    var id: String {
        return rawValue
    }
    
    var title: String {
        return rawValue
        
    }
    
    var ımageName: String {
        switch self {
        case .newGroup:
            return "person.2.fill"
        case .newContact:
            return "person.fill.badge.plus"
        case .newCommunity:
            return "person.3.fill"
        }
    }
    
}


#Preview {
    ChatPartnerPickerScreen()
}
