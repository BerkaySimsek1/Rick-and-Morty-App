//
//  ServiceError.swift
//  Rick and Morty App
//
//  Created by Berkay on 29.07.2024.
//

import Foundation

enum ServiceError: Error {

    case decodingError
    case dataError
    case urlError
    case responseError

    var localizedDescription: String {

        switch self {
        case .decodingError:
            return "Decode edilemedi"
        case .dataError:
            return "Data error"
        case .urlError:
            return "URL error"
        case .responseError:
            return "Response error"
        }
    }
}
