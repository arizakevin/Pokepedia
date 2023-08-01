//
//  api.swift
//  PokePedia
//
//  Created by Kevin Ariza on 22/07/23.
//

import Foundation
    
class PokemonViewModel: ObservableObject {
    @Published var pokemonList = [Pokemon]() {
        didSet {
            savePokemonData()
        }
    }
    @Published var imageDatas: [Int: Data] = [:]
    
    init() {
        loadPokemonData()
        if pokemonList.isEmpty {
            get1stGenPokemon()
        }
    }
    
    func savePokemonData() {
        if let encodedData = try? JSONEncoder().encode(pokemonList) {
            UserDefaults.standard.set(encodedData, forKey: "PokemonData")
        }
    }
    
    func loadPokemonData() {
        if let savedData = UserDefaults.standard.data(forKey: "PokemonData"),
           let decodedData = try? JSONDecoder().decode([Pokemon].self, from: savedData) {
            pokemonList = decodedData
        }
    }
    
    func get1stGenPokemon() {
        var tempPokemonList = [Int: Pokemon]()
        let group = DispatchGroup()
        
        for i in 1...151 {
            group.enter()
            let url = URL(string: "https://pokeapi.co/api/v2/pokemon/\(i)")!
            let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
                if let error = error {
                    print("Error: \(error)")
                } else if let data = data {
                    do {
                        let json = try JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
                        let id = json["id"] as! Int
                        let name = json["name"] as! String
                        let typesArray = json["types"] as! [[String: Any]]
                        var types: [String] = []
                        for type in typesArray {
                            let typeDict = type["type"] as! [String: Any]
                            types.append(typeDict["name"] as! String)
                        }
                        let height = json["height"] as! Int
                        let weight = json["weight"] as! Int
                        let sprites = json["sprites"] as! [String: Any]
                        let sprite = sprites["front_default"] as! String
                        let pokemon = Pokemon(id: id, name: name, types: types, generation: 1, height: height, weight: weight, sprite: sprite)
                        DispatchQueue.main.async {
                            tempPokemonList[id] = pokemon
                        }
                        group.leave()
                    } catch {
                        print("JSON error: \(error.localizedDescription)")
                    }
                }
            }
            task.resume()
        }
        
        group.notify(queue: .main) {
            self.pokemonList = Array(tempPokemonList.values).sorted { $0.id < $1.id }
        }
    }
    
    func loadImage(for pokemon: Pokemon) {
        guard let url = URL(string: pokemon.sprite) else { return }
        URLSession.shared.dataTask(with: url) { data, _, _ in
            guard let data = data else { return }
            DispatchQueue.main.async {
                self.imageDatas[pokemon.id] = data
            }
        }.resume()
    }

}
