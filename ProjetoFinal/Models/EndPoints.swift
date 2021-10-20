//
//  EndPoints.swift
//  ProjetoFinal
//
//  Created by Marilise Morona on 19/10/21.
//

import Foundation

struct ListPokemons {
    var count : Int?
    var next : String?
    var previous: String?
    var results: [ResultsPokemon]?
}

struct ResultsPokemon {
    var name : String?
    var url : String?
}

struct Pokemon {
    var id : Int?
    var name : String?
    var base_experience : Int?
    var height : Int?
    var weight : Int?
    var location_area_encounter : String?
    var sprites: String?
}
