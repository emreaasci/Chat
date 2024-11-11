//
//  ChatPartnerPickerViewModel.swift
//  Chat
//
//  Created by Emre Aşcı on 7.11.2024.
//

import Foundation

enum ChannelCreationRoute {
    case groupPartnerPicker
    case setUpGroupChat
}


enum ChannelCotants {
    static let maxGroupParticipants = 12
}

final class ChatPartnerPickerViewModel: ObservableObject {
    @Published var navStack = [ChannelCreationRoute]()
    @Published var selectedChatPartners = [UserItems]()
    
    
    var showSelectedUsers: Bool {
        return !selectedChatPartners.isEmpty
        
    }
    
    var disableNextButton: Bool {
        return selectedChatPartners.isEmpty
    }
    
    
    func handleItemSelection(_ item: UserItems) {
        if isUserSelected(item) {
            guard let index = selectedChatPartners.firstIndex(where: { $0.id == item.id}) else { return }
            selectedChatPartners.remove(at: index)
        } else {
            selectedChatPartners.append(item)
        }
    }
    
    func isUserSelected(_ item: UserItems) -> Bool {
        let isSelected = selectedChatPartners.contains(where: { $0.id == item.id})
        return isSelected
    }
    
}
