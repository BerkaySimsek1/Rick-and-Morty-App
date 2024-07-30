//
//  CharacterView.swift
//  Rick and Morty App
//
//  Created by Berkay on 29.07.2024.
//

import SwiftUI

struct CharacterView: View {
    @StateObject private var viewModel = CharacterViewModel()
    
    @State private var status = ""
    
    let columns = [GridItem(.flexible()), GridItem(.flexible())]
    
    var body: some View {
        NavigationStack {
            CharacterPickerView(status: $status)
            ScrollView {
                LazyVGrid(columns: columns, spacing: 16) {
                    ForEach(viewModel.characters) { character in
                        CharacterRow(character: character)
                            .onAppear {
                                viewModel.loadMoreIfNeeded(currentItem: character)
                            }
                    }
                    
                    if viewModel.loading {
                        ProgressView()
                            .frame(maxWidth: .infinity)
                            .padding()
                    }
                }
            }
            .onAppear {
                viewModel.loadCharacters(filter: "")
            }
            .onChange(of: status, { oldValue, newValue in
                viewModel.loadCharacters(filter: newValue)
            })
            .navigationTitle("Characters")
            .alert(item: $viewModel.errorMessage) { errorMessage in
                Alert(
                    title: Text("Error"),
                    message: Text(errorMessage.message),
                    dismissButton: .default(Text("OK"))
                )
            }
        }
    }
}

#Preview {
    CharacterView()
}
