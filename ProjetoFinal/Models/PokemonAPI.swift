//
//  PokemonAPI.swift
//  ProjetoFinal
//
//  Created by Elisa Kalil on 28/10/21.
//

import Foundation

protocol PokemonAPI {
    
    func setPokemonURL(_ id: Int) -> String
    
    func setListPokemonURL() -> String
    
    func getListPokemons(urlString: String, method: HTTPMethod, success: @escaping (Pokemons) -> Void, failure: @escaping (SGApiError) -> Void)
    
    func getPokemons(urlString: String, method: HTTPMethod, success: @escaping (Pokemon) -> Void, failure: @escaping (SGApiError) -> Void)
    
}
