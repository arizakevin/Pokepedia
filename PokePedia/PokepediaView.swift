//
//  PokepediaView.swift
//  PokePedia
//
//  Created by Kevin Ariza on 21/07/23.
//

import SwiftUI
import Combine

struct PokepediaView: View {
    @ObservedObject var viewModel = PokemonViewModel()
    @State private var searchText = ""
    
    var body: some View {
        NavigationView {
            VStack {
                TextField("Search", text: $searchText)
                    .foregroundColor(getTypeColor(forType: searchText.lowercased()))
                    .padding(7)
                    .background(Color(.systemGray6))
                    .cornerRadius(8)
                    .padding(.horizontal)
                
                let filteredPokemon = viewModel.pokemonList.filter { pokemon in
                    searchText.isEmpty ||
                    pokemon.name.localizedCaseInsensitiveContains(searchText) ||
                    pokemon.types.contains(where: { $0.localizedCaseInsensitiveContains(searchText) })
                }
                
                if filteredPokemon.isEmpty {
                    Spacer()
                    Text("No results...")
                        .foregroundColor(.gray)
                    Spacer()
                } else {
                    List {
                        ForEach(viewModel.pokemonList.filter { pokemon in
                            searchText.isEmpty ||
                            pokemon.name.localizedCaseInsensitiveContains(searchText) ||
                            pokemon.types.contains(where: { $0.localizedCaseInsensitiveContains(searchText) })
                        }, id: \.id) { pokemon in
                            NavigationLink(destination: PokemonDetailView(pokemon: pokemon)) {
                                VStack(alignment: .leading) {
                                    Spacer()
                                    
                                    Text(pokemon.name.capitalized)
                                        .font(.headline)
                                    
                                    Spacer()
                                    
                                    HStack {
                                        VStack(alignment: .leading) {
                                            Text("Types:")
                                            ForEach(pokemon.types, id: \.self) { type in
                                                Text(type.capitalized)
                                                    .foregroundColor(getTypeColor(forType: type))
                                            }
                                        }
                                        
                                        Spacer()
                                        
                                        VStack(alignment: .leading) {
                                            Text("Height: \(pokemon.height)")
                                            Text("Weight: \(pokemon.weight)")
                                        }
                                        
                                        Spacer()
                                        
                                        VStack {
                                            Text("Generation:")
                                            Text("\(pokemon.generation)")
                                        }
                                    }
                                    .font(.subheadline)
                                    .foregroundColor(.secondary)
                                    
                                    if let data = self.viewModel.imageDatas[pokemon.id], let uiImage = UIImage(data: data) {
                                        Image(uiImage: uiImage)
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)
                                            .frame(width: 100, height: 100)
                                    } else {
                                        ProgressView()
                                            .frame(width: 100, height: 100)
                                    }
                                }
                                .onAppear {
                                    if self.viewModel.imageDatas[pokemon.id] == nil {
                                        self.viewModel.loadImage(for: pokemon)
                                    }
                                }
                            }
                        }
                    }
                }
            }
            .navigationTitle("Pokedex")
            .onAppear {
                viewModel.get1stGenPokemon()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        PokepediaView()
    }
}
