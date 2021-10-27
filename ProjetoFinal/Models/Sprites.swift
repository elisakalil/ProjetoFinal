//
//  Sprites.swift
//  ProjetoFinal
//
//  Created by Marilise Morona on 26/10/21.
//

import Foundation

struct Sprites: Codable {
    var front_default: String?
    
    enum CodingKeys: String, CodingKey {
        case front_default
    }
}
