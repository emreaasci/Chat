//
//  AuthHeaderView.swift
//  Chat
//
//  Created by Emre Aşcı on 6.11.2024.
//

import SwiftUI

struct AuthHeaderView: View {
    var body: some View {
        HStack {
            Image(systemName: "cloud.rain.circle")
                .resizable()
                .frame(width: 40,height: 40)
            
            Text("HOLDER")
                .font(.largeTitle)
                .foregroundStyle(.black)
                .fontWeight(.semibold)
        }
    }
}

#Preview {
    AuthHeaderView()
}
