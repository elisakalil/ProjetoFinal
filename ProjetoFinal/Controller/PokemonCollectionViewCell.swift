//
//  PokemonCollectionViewCell.swift
//  ProjetoFinal
//  Created by Elisa Kalil on 21/10/21.

import UIKit

class PokemonCollectionViewCell: UICollectionViewCell {
    
    // MARK: Properties
    static let id: String = "PokemonCollectionViewCell"
    
    // MARK: Outlets
    @IBOutlet weak var viewCellPokemon: UIView!
    @IBOutlet weak var imagePokemon: UIImageView!
    @IBOutlet weak var labelPokemon: UILabel!
    
    // MARK: Overrides
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }
    
    // MARK: Methods
    func setupUI (){
        viewCellPokemon.layer.cornerRadius = 12
    }
    
}
