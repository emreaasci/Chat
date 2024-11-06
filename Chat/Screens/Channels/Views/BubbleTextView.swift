//
//  BubbleTextView.swift
//  Chat
//
//  Created by Emre Aşcı on 6.11.2024.
//

import SwiftUI

struct BubbleTextView: View {
    let item: MessageItem
    
    
    
    
    var body: some View {
        VStack (alignment: item.horizontalAlignmnet, spacing: 3) {
            Text("Hello, World!  emaadsasasasa")
            
                .padding(10)
                .background(item.backgroundColor)
                .clipShape(RoundedRectangle(cornerRadius: 10 , style: .continuous))
            
            timeStampTextView()
        }
        
        .shadow(color:Color(.systemGray3) ,radius: 10,x: 0,y: 5)
        .frame(maxWidth: .infinity, alignment: item.alignment)
        .padding(.leading,item.direction == .received ? 5 :100)
        .padding(.trailing, item.direction == .received ? 100 : 5)
        
        
        
    }
    
    private func timeStampTextView() -> some View {
        HStack {
            Text("3.12 PM")
                .font(.system(size: 10))
                .foregroundStyle(.black)
            if item.direction == .sent {
                Image(systemName: "checkmark.square")
                    .resizable()
                    .renderingMode(.template)
                    .frame(width: 15,height: 15)
                    .foregroundStyle(Color(.systemBlue))
            }
        }
    }
}

#Preview {
    ScrollView {
        BubbleTextView(item: .sentPlaceholder)
        BubbleTextView(item: .receivedPlaceholder)
    }
    
    .frame(maxWidth: .infinity)
    .background(Color.gray.opacity(0.3))
    
    
}
