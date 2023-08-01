//
//  PokemonElement.swift
//  PokePedia
//
//  Created by Kevin Ariza on 21/07/23.
//

import Foundation

struct Pokemon: Identifiable, Codable {
    var id: Int
    var name: String
    var types: [String]
    var generation: Int
    var height: Int
    var weight: Int
    var sprite: String
}

//let ditto = Pokemon(
//    id: 132,
//    name: "Ditto",
//    types: ["Normal"],
//    generation: 1,
//    height: 10,
//    weight: 10,
//    sprite: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/132.png"
//)
//
//let mew = Pokemon(
//    id: 151,
//    name: "Mew",
//    types: ["Psychic"],
//    generation: 1,
//    height: 10,
//    weight: 10,
//    sprite: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/151.png"
//)
