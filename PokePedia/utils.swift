//
//  utils.swift
//  PokePedia
//
//  Created by Kevin Ariza on 22/07/23.
//

import Foundation
import SwiftUI

func getTypeColor(forType type: String) -> Color {
    switch type {
    case "dragon":
        return Color(red: 0.4, green: 0.4, blue: 1.0) // Light blue
    case "electric":
        return .yellow
    case "fighting":
        return .red
    case "fire":
        return .orange
    case "flying":
        return Color(red: 0.6, green: 0.6, blue: 1.0) // Light gray
    case "ghost":
        return Color(red: 0.5, green: 0, blue: 0.5) // Dark purple
    case "grass":
        return .green
    case "ground":
        return Color(red: 0.6, green: 0.4, blue: 0.2) // Light brown
    case "ice":
        return .cyan
    case "normal":
        return .gray
    case "poison":
        return Color(red: 0.7, green: 0, blue: 0.7) // Light purple
    case "psychic":
        return .pink
    case "rock":
        return Color(red: 0.4, green: 0.3, blue: 0.2) // Dark brown
    case "water":
        return Color(red: 0, green: 0, blue: 1.0) // Dark blue
    case "bug":
            return Color(red: 0.6, green: 0.5, blue: 0.0) // Green brownish
    case "fairy":
        return Color(red: 1.0, green: 0.5, blue: 0.7) // Light pink
    default:
        return .black
    }
}

func getBackgroundTypeColor(forType type: String) -> Color {
    switch type {
    case "dragon":
        return Color(red: 0.6, green: 0.6, blue: 1.0) // Lighter blue
    case "electric":
        return Color.yellow.opacity(0.5)
    case "fighting":
        return Color.red.opacity(0.5)
    case "fire":
        return Color.orange.opacity(0.5)
    case "flying":
        return Color(red: 0.8, green: 0.8, blue: 1.0)
    case "ghost":
        return Color.purple.opacity(0.5)
    case "grass":
        return Color.green.opacity(0.5)
    case "ground":
        return Color.brown.opacity(0.5)
    case "ice":
        return Color.cyan.opacity(0.5)
    case "normal":
        return Color.gray.opacity(0.5)
    case "poison":
        return Color.purple.opacity(0.5)
    case "psychic":
        return Color.pink.opacity(0.5)
    case "rock":
        return Color.brown.opacity(0.5)
    case "water":
        return Color.blue.opacity(0.5)
    case "bug":
        return Color(red: 0.8, green: 0.7, blue: 0.2) // Lighter green brownish
    case "fairy":
        return Color(red: 1.0, green: 0.7, blue: 0.9) // Lighter pink
    default:
        return .black
    }
}
