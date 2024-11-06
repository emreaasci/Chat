//
//  MainTabView.swift
//  Chat
//
//  Created by Emre Aşcı on 5.11.2024.
//

import SwiftUI

struct MainTabView: View {
    init() {
        makeTabBarOpaque()
    }
    
    
    var body: some View {
        TabView {
            placeholderItemView("PLACEHOLDER")
                .tabItem{
                    Image(systemName: Tab.updates.icon)
                    Text(Tab.updates.title)
                }
            ChannelTabScreen()
                .tabItem{
                    Image(systemName: Tab.chats.icon)
                    Text(Tab.chats.title)
                }
            placeholderItemView("PLACEHOLDER")
                .tabItem{
                    Image(systemName: Tab.settings.icon)
                    Text(Tab.settings.title)
                }
        }
    }
    
    private func makeTabBarOpaque() {
        let appereance = UITabBarAppearance()
        appereance.configureWithOpaqueBackground()
        UITabBar.appearance().standardAppearance = appereance
        UITabBar.appearance().scrollEdgeAppearance = appereance
    }
}


extension MainTabView {
    private func placeholderItemView(_ title:String) -> some View {
        ScrollView {
            VStack {
                ForEach(0..<120) { _ in
                    ZStack{
                        Text(title)
                            .bold()
                            .frame(maxWidth : .infinity)
                            .frame(height: 120)
                            .background(Color.red.opacity(0.5))
                    }
                   
                }
            }
        }
    }
    
    
    private enum Tab: String {
        case updates, chats, settings
        
        
        fileprivate var title: String {
            return rawValue.capitalized
        }
        
        
        
        fileprivate var icon: String {
            switch self {
            case .updates:
                return "circle.dashed.inset.filled"
            case .chats:
                return "message"
            case .settings:
                return "gear"
            }
        }
    }
}





#Preview {
    MainTabView()
}

