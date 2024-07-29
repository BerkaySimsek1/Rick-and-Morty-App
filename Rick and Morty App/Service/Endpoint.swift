//
//  Endpoint.swift
//  Rick and Morty App
//
//  Created by Berkay on 29.07.2024.
//

import Foundation

enum endpointType {
    case character
    case episode
    case location

    var apiTypeString: String {
        switch self {
        case .character:
            return "character"
        case .episode:
            return "episode"
        case .location:
            return "location"
        }
    }
}
