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
    private var status: String = ""
    private var charName: String = ""
    
    func loadCharacters(status: String = "", charName: String = "") {
        guard !isFetching else { return }
        
        if self.status != status || self.charName != charName {
            resetState()
            self.status = status
            self.charName = charName
        }
        
        loading = true
        isFetching = true
        errorMessage = nil
        
        service.fetchCharacter(page: currentPage, charName: charName, status: status, endpoint: .character) { [weak self] result in
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
    
    func resetState() {
        currentPage = 1
        characters.removeAll()
        totalPages = 0
    }
    
    func loadMoreIfNeeded(currentItem character: Character?) {
        guard let character = character else {
            loadCharacters(status: status, charName: charName)
            return
        }
        
        let thresholdIndex = characters.index(characters.endIndex, offsetBy: -5)
        if characters.firstIndex(where: { $0.id == character.id }) == thresholdIndex {
            loadCharacters(status: status, charName: charName)
        }
    }
}
