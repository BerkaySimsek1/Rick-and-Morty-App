//
//  CharacterVM.swift
//  Rick and Morty App
//
//  Created by Berkay on 29.07.2024.
//

import SwiftUI

class CharacterViewModel: ObservableObject {
    @Published var characters: [Character] = []
    @Published var loading = false
    @Published var errorMessage: String?
    
    private let service = Service()
    
    func loadCharacters(filter: String = "") {
        loading = true
        errorMessage = nil
        
        service.fetchCharacter(filter: filter, endpoint: .character) { [weak self] result in
            DispatchQueue.main.async {
                self?.loading = false
                
                switch result {
                case .success(let characterModel):
                    self?.characters = characterModel.results
                case .failure(let error):
                    switch error {
                    case .urlError:
                        self?.errorMessage = "Invalid URL."
                    case .responseError:
                        self?.errorMessage = "Error fetching data."
                    case .dataError:
                        self?.errorMessage = "No data received."
                    case .decodingError:
                        self?.errorMessage = "Failed to decode data."
                    }
                }
            }
        }
    }
}

