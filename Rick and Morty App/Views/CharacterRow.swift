//
//  CharacterRow.swift
//  Rick and Morty App
//
//  Created by Berkay on 29.07.2024.
//

import SwiftUI

struct CharacterRow: View {
    
    let character: Character
    
    var body: some View {
        ZStack {
            VStack {
                AsyncImage(url: URL(string: character.image)) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 100, height: 100)
                        .clipShape(RoundedRectangle(cornerRadius: 20))
                } placeholder: {
                    ProgressView()
                }
                Text(character.name)
                    .bold()
                    .font(.title2)
                Text(character.status)
                    .font(.headline)
                    .foregroundStyle(getTextColor(for: character.status))
                
                Text(character.location.name)
                    .multilineTextAlignment(.center)
                    .frame(width: 150)
            }.frame(width: 170, height: 300)
        }.background(.purple.opacity(0.4))
            .clipShape(RoundedRectangle(cornerRadius: 20))
    }
    
    func getTextColor(for status: String) -> Color {
            switch status {
            case "Alive":
                return .green
            case "Dead":
                return .red
            default:
                return .gray // Default color if no match
            }
        }
}

struct CharacterModel_Previews: PreviewProvider {
    static var previews: some View {
        // Örnek bir karakter sonucu oluşturuluyor
        let exampleCharacter = Character(
            id: 1,
            name: "Rick Sanchez",
            status: "Alive",
            species: "Human",
            type: "",
            gender: "Male",
            origin: Location(name: "Earth (C-137)", url: "https://rickandmortyapi.com/api/location/1"),
            location: Location(name: "Earth (Replacement Dimension)", url: "https://rickandmortyapi.com/api/location/20"),
            image: "https://rickandmortyapi.com/api/character/avatar/1.jpeg",
            episode: ["https://rickandmortyapi.com/api/episode/1"],
            url: "https://rickandmortyapi.com/api/character/1",
            created: "2017-11-04T18:48:46.250Z"
        )

        // Örnek karakter modelini bir SwiftUI görünümü içerisinde göster
        CharacterRow(character: exampleCharacter)
            .previewLayout(.sizeThatFits)
            .padding()
    }
}
