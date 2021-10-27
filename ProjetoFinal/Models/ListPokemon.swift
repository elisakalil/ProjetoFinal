//
//  ListPokemon.swift
//  ProjetoFinal
//
//  Created by Marilise Morona on 26/10/21.
//

import Foundation

struct ListPokemon: Codable {
    var count : Int?
    var next : String?
    var previous: String?
    var results: [Results]
}
