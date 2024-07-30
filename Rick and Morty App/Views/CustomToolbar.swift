//
//  CustomToolbar.swift
//  Rick and Morty App
//
//  Created by Berkay on 30.07.2024.
//

import SwiftUI

struct CustomToolbar<Content: View>: View {
    let height: CGFloat
    let content: Content
    
    init(height: CGFloat, @ViewBuilder content: () -> Content) {
        self.height = height
        self.content = content()
    }
    
    var body: some View {
        VStack {
            content
        }.background(Color(hex: 0xff3a4767))
        .frame(height: height)
        .frame(maxWidth: .infinity)
        
    }
}

#Preview {
    CustomToolbar(height: 80) {
        Text("hi")
    }
}
