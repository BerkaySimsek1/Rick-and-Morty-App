//
//  Service.swift
//  Rick and Morty App
//
//  Created by Berkay on 29.07.2024.
//
import Foundation

class Service: ObservableObject {
    static let baseUrl = "https://rickandmortyapi.com/api/"
    
    func fetchCharacter(page: Int = 1, filter: String = "", endpoint: endpointType, completion: @escaping (Result<CharacterResponse, ServiceError>) -> Void) {
        guard let url = URL(string: Service.baseUrl + endpoint.apiTypeString + "/?page=" + String(page) + "&status=" + filter ) else {
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
                if let jsonString = String(data: data, encoding: .utf8) {
                                   print("JSON Response: \(jsonString)")
                               }
                               
                let response = try JSONDecoder().decode(CharacterResponse.self, from: data)
                               completion(.success(response))
                
            } catch {
                completion(.failure(.decodingError))
            }
        }
        task.resume()
        
    }
    
    
}
