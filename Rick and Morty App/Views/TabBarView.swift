//
//  TabBarView.swift
//  Rick and Morty App
//
//  Created by Berkay on 31.07.2024.
//

import SwiftUI

struct TabBarView: View {
    var body: some View {
        TabView {
            CharacterView().tabItem {
                Label("Characters", systemImage: "person.fill")
            }
            
            EpisodeView().tabItem {
                Label("Episodes", systemImage: "video.fill")
            }
            
            LocationView().tabItem {
                Label("Locations", systemImage: "globe.americas.fill")
            }
        }.onAppear() {
            
            UITabBar.appearance().barTintColor = UIColor(Constants.backgroundColor)
        }

        .tint(.purple)
        
    }
}

#Preview {
    TabBarView()
}
