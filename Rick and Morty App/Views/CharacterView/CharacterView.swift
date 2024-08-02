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
    @State private var searchText = ""
    
    let columns = [GridItem(.flexible()), GridItem(.flexible())]
    
    var body: some View {
        NavigationStack {
            ScrollView {
                CharacterPickerView(status: $status)
                
                LazyVGrid(columns: columns, spacing: 16) {
                    ForEach(viewModel.characters) { character in
                        NavigationLink(destination: CharacterDetailView(character: character)) {
                            CharacterRow(character: character)
                                .onAppear {
                                    viewModel.loadMoreIfNeeded(currentItem: character)
                                }
                                .transition(.opacity.combined(with: .scale))
                        }
                    }
                    
                    if viewModel.loading {
                        ProgressView()
                            .frame(maxWidth: .infinity)
                            .padding()
                    }
                }.animation(.linear, value: viewModel.characters)
            }
            .onAppear {
                viewModel.loadCharacters(status: "")
            }
            .onChange(of: status) { oldValue, newValue in
                viewModel.loadCharacters(status: newValue, charName: searchText)
            }
            .onChange(of: searchText) { oldValue, newValue in
                viewModel.loadCharacters(status: status, charName: newValue)
            }
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    CustomToolbar(height: 80) {
                        Text("Characters")
                            .foregroundColor(.white)
                            .font(.largeTitle)
                            .bold()
                            .background(Constants.backgroundColor)
                    }
                    
                }
            }
            .toolbarBackground(Constants.backgroundColor, for: .navigationBar)
            .toolbarBackground(.visible, for: .navigationBar)
            .searchable(text: $searchText, prompt: "Search characters")
            .alert(item: $viewModel.errorMessage) { errorMessage in
                Alert(
                    title: Text("Error"),
                    message: Text(errorMessage.message),
                    dismissButton: .default(Text("OK"))
                )
            }
            .foregroundColor(.white)
            .background(Constants.backgroundColor)
        }.tint(.white)
    }
}

#Preview {
    CharacterView()
}
