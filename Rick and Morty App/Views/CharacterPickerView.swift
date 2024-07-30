//
//  CharacterPickerView.swift
//  Rick and Morty App
//
//  Created by Berkay on 30.07.2024.
//

import SwiftUI

struct CharacterPickerView: View {
    
    @Binding var status: String
    @State private var selectedTag: Int = 0 // Initialize with a default selected tag

    var body: some View {
        HStack() {
            Spacer()
            Button(action: {
                selectedTag = 0
                status = ""
            }) {
                Text("All")
                    .padding()
                    .foregroundColor(.white)
                    .background(selectedTag == 0 ? .blue : .gray
                    )
                    .cornerRadius(10)
                    .shadow(color: selectedTag == 0 ? .blue : .clear, radius: 20)
            }
            Spacer()
            Button(action: {
                selectedTag = 1
                status = "Alive"
            }) {
                Text("Alive")
                    .padding()
                    .foregroundColor(.white)
                    .background(selectedTag == 1 ? .green.opacity(1) : .gray
                    )
                    .cornerRadius(10)
                    .shadow(color: selectedTag == 1 ? .green : .clear, radius: 20)
            }
            Spacer()
            Button(action: {
                selectedTag = 2
                status = "Dead"
            }) {
                Text("Dead")
                    .padding()
                    .foregroundColor(.white)
                    .background(selectedTag == 2 ? .red.opacity(0.7) : .gray
                    )
                    .cornerRadius(10)
                    .shadow(color: selectedTag == 2 ? .red : .clear, radius: 20)
            }
            Spacer()
            Button(action: {
                selectedTag = 3
                status = "Unknown"
            }) {
                Text("Unknown")
                    .padding()
                    .foregroundColor(.white)
                    .background(.gray
                    )
                    .cornerRadius(10)
                    .shadow(color: selectedTag == 3 ? .black : .clear, radius: 20)
            }
            Spacer()
        }
    }
}

struct CharacterPickerView_Previews: PreviewProvider {
    static var previews: some View {
        CharacterPickerView(status: .constant("Alive"))
    }
}
