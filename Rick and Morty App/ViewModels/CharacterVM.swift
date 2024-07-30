//
//  CharacterVM.swift
//  Rick and Morty App
//
//  Created by Berkay on 29.07.2024.
//

import SwiftUI

struct ErrorMessage: Identifiable {
    let id = UUID()
    var message: String
}


class CharacterViewModel: ObservableObject {
    @Published var characters: [Character] = []
    @Published var loading = false
    @Published var errorMessage: ErrorMessage?
    
    private let service = Service()
    
    private var currentPage = 1
    private var totalPages = 0
    private var isFetching = false
    private var filter: String = ""
    
    func loadCharacters(filter: String = "") {
        guard !isFetching else { return }
        
        loading = true
        isFetching = true
        errorMessage = nil
        
        // If a new filter is applied, reset pagination
        if self.filter != filter {
            self.filter = filter
            currentPage = 1
            characters.removeAll()
        }
        
        service.fetchCharacter(page: currentPage, filter: filter, endpoint: .character) { [weak self] result in
            DispatchQueue.main.async {
                self?.loading = false
                self?.isFetching = false
                
                switch result {
                case .success(let characterModel):
                    self?.characters.append(contentsOf: characterModel.results)
                    self?.totalPages = characterModel.info.pages
                    self?.currentPage += 1
                case .failure(let error):
                    switch error {
                    case .urlError:
                        self?.errorMessage?.message = "Invalid URL."
                    case .responseError:
                        self?.errorMessage?.message = "Error fetching data."
                    case .dataError:
                        self?.errorMessage?.message = "No data received."
                    case .decodingError:
                        self?.errorMessage?.message = "Failed to decode data."
                    }
                }
            }
        }
    }
    
    func loadMoreIfNeeded(currentItem character: Character?) {
        // Check if we need to load more characters
        guard let character = character else {
            loadCharacters(filter: filter)
            return
        }
        
        let thresholdIndex = characters.index(characters.endIndex, offsetBy: -5)
        if characters.firstIndex(where: { $0.id == character.id }) == thresholdIndex {
            loadCharacters(filter: filter)
        }
    }
}
