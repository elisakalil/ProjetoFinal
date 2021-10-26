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
    var base_experience : Int?
    var height : Int?
    var weight : Int?
    var location_area_encounter : String?
    var sprites: Sprites?
    
    enum CodingKeys: String, CodingKey{
        case id
        case name
        case base_experience
        case height
        case weight
        case location_area_encounter
        case sprites
    }
}

struct Pokemons: Codable {
    var poks: [Pokemon]?
}
