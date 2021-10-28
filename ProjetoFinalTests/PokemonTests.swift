//
//  PokemonTests.swift
//  ProjetoFinalTests
//
//  Created by Elisa Kalil on 28/10/21.
//

import XCTest
@testable import ProjetoFinal

class APISpy: PokemonAPI {
    
    var apiCalls = 0
    
    func setPokemonURL(_ id: Int) -> String {
        return ""
    }
    
    func setListPokemonURL() -> String {
        return ""
    }
    
    func getListPokemons(urlString: String, method: HTTPMethod, success: @escaping (Pokemons) -> Void, failure: @escaping (SGApiError) -> Void) {
        apiCalls += 1
    }
    
    func getPokemons(urlString: String, method: HTTPMethod, success: @escaping (Pokemon) -> Void, failure: @escaping (SGApiError) -> Void) {
    }
    
    
}

class PokemonTests: XCTestCase {

    func test_init_willCallAPIOnce() {
        // setup
        let api = APISpy()
        let sut = HomeViewController(api: api)
        // exercise
        sut.loadViewIfNeeded()
        // verify
        XCTAssertEqual(api.apiCalls, 1)
    }

}
