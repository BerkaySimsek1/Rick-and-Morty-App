//
//  CharacterView.swift
//  Rick and Morty App
//
//  Created by Berkay on 29.07.2024.
//

import SwiftUI

struct CharacterView: View {
    let service = Service()
    
    let columns = [GridItem(.flexible()), GridItem(.flexible())]
    
    @StateObject private var viewModel = CharacterViewModel()
    
    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVGrid(columns: columns, spacing: 16) {
                    ForEach(viewModel.characters) { character in
                        CharacterRow(character: character)
                    }
                }
                
                .onAppear {
                    viewModel.loadCharacters(filter: "")
                }.navigationTitle("Characters")
            }
        }
    }
}


#Preview {
    CharacterView()
}
