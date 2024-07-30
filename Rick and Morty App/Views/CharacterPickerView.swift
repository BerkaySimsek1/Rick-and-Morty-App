//
//  CharacterPickerView.swift
//  Rick and Morty App
//
//  Created by Berkay on 30.07.2024.
//

//
//  CharacterPickerView.swift
//  Rick and Morty App
//
//  Created by Berkay on 30.07.2024.
//

import SwiftUI

struct CharacterPickerView: View {
    
    @Binding var status: String
    @State private var selectedTag: Int = 0
    
    private let buttons: [(tag: Int, title: String, color: Color)] = [
        (0, "", .blue),
        (1, "Alive", .green),
        (2, "Dead", .red),
        (3, "Unknown", .gray)
    ]

    var body: some View {
        HStack {
            ForEach(buttons, id: \.tag) { button in
                Spacer()
                Button(action: {
                    selectedTag = button.tag
                    status = button.title
                }) {
                    Text(button.title == "" ? "All" : button.title)
                        .padding()
                        .foregroundColor(.white)
                        .background(selectedTag == button.tag ? button.color : .gray)
                        .cornerRadius(10)
                        .shadow(color: selectedTag == button.tag ? button.color : .clear, radius: 15, y: 5)
                }
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
