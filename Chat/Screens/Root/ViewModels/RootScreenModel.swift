//
//  RootScreenModel.swift
//  Chat
//
//  Created by Emre Aşcı on 7.11.2024.
//

import Foundation
import Combine


final class RootScreenModel: ObservableObject {
    @Published private(set) var authState = AuthState.pending
    private var cancellable: AnyCancellable?
    
    
    init() {
        cancellable = AuthManager.shared.authState.receive(on: DispatchQueue.main)
            .sink{[weak self] latestAuthState in
                self?.authState = latestAuthState}
    }
    
}
