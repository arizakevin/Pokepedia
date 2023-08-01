//
//  PokemonDetailView.swift
//  PokePedia
//
//  Created by Kevin Ariza on 22/07/23.
//

import Foundation
import SwiftUI

struct PokemonDetailView: View {
    let pokemon: Pokemon

    var body: some View {
        let colors = pokemon.types.map { getBackgroundTypeColor(forType: $0) }
        let gradient = LinearGradient(gradient: Gradient(colors: colors), startPoint: .top, endPoint: .bottom)
        
        return ZStack {
            gradient.edgesIgnoringSafeArea(.all)
            VStack {
                Text(pokemon.name.capitalized)
                    .font(.largeTitle)
                if let url = URL(string: pokemon.sprite), let imageData = try? Data(contentsOf: url), let uiImage = UIImage(data: imageData) {
                    Image(uiImage: uiImage)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 200, height: 200)
                }
                HStack {
                    Text("Types:")
                        .font(.title2)
                    ForEach(pokemon.types, id: \.self) { type in
                        Text(type.capitalized)
                            .font(.title2)
                            .foregroundColor(getTypeColor(forType: type))
                    }
                }
                Text("Generation: \(pokemon.generation)")
                    .font(.title2)
                Text("Height: \(pokemon.height)")
                    .font(.title2)
                Text("Weight: \(pokemon.weight)")
                    .font(.title2)
            }
            .padding()
        }
    }
}
