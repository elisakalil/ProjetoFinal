//
//  PokemonCollectionViewCell.swift
//  ProjetoFinal
//  Created by Elisa Kalil on 21/10/21.


import UIKit

class PokemonCollectionViewCell: UICollectionViewCell {
    
    static let id: String = "PokemonCollectionViewCell"

    @IBOutlet weak var viewCellPokemon: UIView!
    @IBOutlet weak var imagePokemon: UIImageView!
    @IBOutlet weak var labelPokemon: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
        
    }
    
    func setupUI (){
        viewCellPokemon.layer.cornerRadius = 12
    }
}
