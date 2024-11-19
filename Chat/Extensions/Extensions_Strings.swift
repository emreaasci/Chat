//
//  Extensions_Strings.swift
//  Chat
//
//  Created by Emre Aşcı on 19.11.2024.
//


import Foundation


extension String {
    
    func isEmptyOrWhitespace() -> Bool {
        return self.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }
}
