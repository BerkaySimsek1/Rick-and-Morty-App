//
//  EpisodeVM.swift
//  Rick and Morty App
//
//  Created by Berkay on 31.07.2024.
//

import SwiftUI

class EpisodeVM: ObservableObject {
    let service = Service.shared
    @Published var episodes = [Episode]()

    func initialize(character: Character) {
        getCharactersInThisEpisode(character: character)
    }

    func getCharactersInThisEpisode(character: Character) {
        for episode in character.episode {
            service.fetchOnlyEpisodeRequest(url: episode) { [weak self] response in
                switch response {
                case .success(let model):
                    DispatchQueue.main.async {
                        self?.episodes.append(model)
                    }
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
    }
}


