//
//  API.swift
//  ProjetoFinal
//
//  Created by Marilise Morona on 26/10/21.
//

import Foundation

struct API{
    let baseURL = "https://pokeapi.co/api/v2"

    ///Returns the URL string to EndPoint list of Pokemons
    func setListPokemonURL() -> String {
        return "\(baseURL)/\(EndPoints.pokemon)"
    }
    
    func setPokemonURL(_ id: Int) -> String {
        return "\(baseURL)/\(EndPoints.pokemon)/\(id)"
    }
}

