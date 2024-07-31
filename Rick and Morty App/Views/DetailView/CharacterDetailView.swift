//
//  CharacterDetailView.swift
//  Rick and Morty App
//
//  Created by Berkay on 31.07.2024.
//

import SwiftUI

struct CharacterDetailView: View {
    let character: Character
    @StateObject private var episodesVM: EpisodeVM
    
    init(character: Character) {
        self.character = character
        self._episodesVM = StateObject(wrappedValue: EpisodeVM())
    }
    
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                AsyncImage(url: URL(string: character.image)) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: UIScreen.main.bounds.width)
                } placeholder: {
                    ProgressView()
                }
                
                Text(character.name)
                    .foregroundColor(.white)
                    .font(.largeTitle)
                    .padding(.leading, 10)
                
                Text(character.gender)
                    .padding(.leading, 10)
                
                Text(character.status)
                    .padding(.leading, 10)
                
                Text(character.location.name)
                    .padding(.leading, 10)
                
                Text("Episodes:")
                    .font(.title2)
                    .padding(.leading, 10)
                    .padding(.top, 20)
                ScrollView(.horizontal) {
                    LazyHGrid(rows: [GridItem(.adaptive(minimum: 150))], spacing: 10) {
                        ForEach(episodesVM.episodes) { episode in
                            VStack(alignment: .center){
                                Text(episode.episode)
                                    .frame(width: 100,height: 100)
                                    .background(.red)
                                    
                                Text(episode.name)
                                    .padding(.leading, 10)
                                    
                                    .frame(width: 100)
                                    
                            }.padding()
                            .background(.yellow)
                            .padding(.leading, 5)
                        }
                    }
                }
            }
        }
        .background(.blue)
        .ignoresSafeArea()
        .onAppear {
            episodesVM.initialize(character: character)
        }
    }
}
struct CharacterDetailView_Previews: PreviewProvider {
    static var previews: some View {
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
        
        CharacterDetailView(character: exampleCharacter)
    }
}
