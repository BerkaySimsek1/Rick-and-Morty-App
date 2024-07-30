//
//  Service.swift
//  Rick and Morty App
//
//  Created by Berkay on 29.07.2024.
//
import Foundation

class Service: ObservableObject {
    static let baseUrl = "https://rickandmortyapi.com/api/"
    
    func fetchCharacter(page: Int = 1, charName: String, status: String = "", endpoint: endpointType, completion: @escaping (Result<CharacterResponse, ServiceError>) -> Void) {
        guard let url = URL(string: Service.baseUrl + endpoint.apiTypeString + "/?page=" + String(page) + "&status=" + status + "&name=" + charName) else {
            completion(.failure(.urlError))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error{
                completion(.failure(.responseError))
                print(error)
                return
            }
            
            guard let data = data else {
                completion(.failure(.dataError))
                return
            }
            
            do {
                               
                let response = try JSONDecoder().decode(CharacterResponse.self, from: data)
                               completion(.success(response))
                
            } catch {
                completion(.failure(.decodingError))
            }
        }
        task.resume()
        
    }
    
    
}
