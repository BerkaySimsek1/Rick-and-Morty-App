//
//  EpisodeModel.swift
//  Rick and Morty App
//
//  Created by Berkay on 31.07.2024.
//

import Foundation

struct Episode: Codable, Identifiable {
    let id: Int
    let name: String
    let airDate: String
    let episode: String
    let characters: [String]
    let url: String
    let created: String

    enum CodingKeys: String, CodingKey {
        case id, name, airDate = "air_date", episode, characters, url, created
    }
}

struct EpisodesModel: Codable {
    let info: Info
    let results: [Episode]
}
