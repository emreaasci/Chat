//
//  ChatPartnerPickerViewModel.swift
//  Chat
//
//  Created by Emre Aşcı on 7.11.2024.
//

import Foundation
import Firebase
import FirebaseAuth

enum ChannelCreationRoute {
    case groupPartnerPicker
    case setUpGroupChat
}

enum ChannelContants {
    static let maxGroupParticipants = 12
}

enum ChannelCreationError: Error {
    case noChatPartner
    case failedToCreateUniqueIds
}


@MainActor
final class ChatPartnerPickerViewModel: ObservableObject {
    @Published var navStack = [ChannelCreationRoute]()
    @Published var selectedChatPartners = [UserItem]()
    @Published private(set) var users = [UserItem]()
    private var lastCursor: String?
    
    var showSelectedUsers: Bool {
        return !selectedChatPartners.isEmpty
    }
    
    var disableNextButton: Bool {
        return selectedChatPartners.isEmpty
    }
    
    var isPaginatable: Bool {
        return !users.isEmpty
    }
    
    var isDirectChannel: Bool {
        return selectedChatPartners.count == 1
    }
    
    
    init() {
        Task {
            await fetchUsers()
        }
    }
    
    
    
    // MARK: - Public Methods
    
    
    func fetchUsers() async {
        do {
            let userNode = try await UserService.paginateUsers(lastCursor: lastCursor, pageSize: 5)
            var fetchedUser = userNode.users
            guard let currentUid = Auth.auth().currentUser?.uid else { return }
            fetchedUser = fetchedUser.filter{ $0.uid != currentUid}
            
            self.users.append(contentsOf: userNode.users)
            self.lastCursor = userNode.currentCursor
            
            print("lastCursor = \(lastCursor)")
            
        } catch {
            print("failed to fetch users in ChatPartnerPickerViewModel: \(error)")
        }
    }
    
    
    func handleItemSelection(_ item: UserItem) {
        if isUserSelected(item) {
            guard let index = selectedChatPartners.firstIndex(where: { $0.uid == item.uid }) else { return }
            selectedChatPartners.remove(at: index)
        } else {
            selectedChatPartners.append(item)
        }
    }
    
    func isUserSelected(_ user: UserItem) -> Bool {
        let isSelected = selectedChatPartners.contains { $0.uid == user.uid }
        return isSelected
    }
    
    
    func createGroupChannel(_ groupName: String?, completion: @escaping (_ newChannel: ChannelItem) -> Void) {
        let channelCreation = createChannel(groupName)
        switch channelCreation {
        case .success(let channel):
            completion(channel)
        case .failure(let failure):
            print("failure creating channel \(failure.localizedDescription)")
        }
    }
    
    
    func createChannel(_ channelName: String?) -> Result<ChannelItem, Error> {
        guard !selectedChatPartners.isEmpty else { return .failure(ChannelCreationError.noChatPartner)}
        
        
        guard
            let channelId = FirebaseConstants.ChannelsRef.childByAutoId().key,
            let currentId = Auth.auth().currentUser?.uid,
            let messageId = FirebaseConstants.MessagesRef.key
                
        else {
            return .failure(ChannelCreationError.failedToCreateUniqueIds)
        }
            
        let timeStamp = Date().timeIntervalSince1970
        var memberUids = selectedChatPartners.compactMap{ $0.uid }
        memberUids.append(currentId)
        
            
        var channelDict: [String: Any] = [
            .id: channelId,
            .lastMessage: "",
            .creationDate: timeStamp,
            .lastMessageTimeStamp: timeStamp,
            .membersUids: memberUids,
            .membersCount: memberUids.count,
            .adminUids: [currentId],
            .createdBy: currentId
        ]
        
        if let channelName = channelName, !channelName.isEmptyOrWhitespace() {
            channelDict[.name] = channelName
        }
        
        
        FirebaseConstants.ChannelsRef.child(channelId).setValue(channelDict)
        
        memberUids.forEach { userId in
            FirebaseConstants.UserChannelsRef.child(userId).child(channelId).setValue(true)
            
          //  FirebaseConstants.UserDirectChannels.child(userId).child(channelId).setValue(true)
            
        }
        
        if isDirectChannel {
            let chatPartner = selectedChatPartners[0]
            FirebaseConstants.UserDirectChannels.child(currentId).child(chatPartner.uid).setValue([channelId: true])
            FirebaseConstants.UserDirectChannels.child(chatPartner.uid).child(currentId).setValue([channelId: true])
        }
        
        
        var newChannelItem = ChannelItem(channelDict)
        
        newChannelItem.members = selectedChatPartners
        
        return .success(newChannelItem)
        
    }
}

