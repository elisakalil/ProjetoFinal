//
//  Pokemon.swift
//  ProjetoFinal
//
//  Created by Marilise Morona on 26/10/21.
//

import Foundation

struct Pokemon: Codable {
    var id : Int?
    var name : String?
    var height : Int?
    var weight : Int?
    var sprites: Sprites?
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case height
        case weight
        case sprites
    }
}

struct Pokemons: Codable {
    var poks: [Pokemon]?
}
