//
//  ChannelTabViewModel.swift
//  Chat
//
//  Created by Emre Aşcı on 19.11.2024.
//


import Foundation

final class ChannelTabViewModel: ObservableObject {
    
    @Published var navigateToChatRoom = false
    @Published var newChannel: ChannelItem?
    @Published var showChatPartnerPickerView = false
    
    func onNewChannelCreation(_ channel: ChannelItem) {
        showChatPartnerPickerView = false
        newChannel = channel
        navigateToChatRoom = true
    }
}
