//
//  FavoriteTableViewCell.swift
//  ProjetoFinal
//
//  Created by Rayana Prata Neves on 27/10/21.
//

import UIKit

class FavoriteTableViewCell: UITableViewCell {

    // MARK: Properties
    static let id: String = "FavoriteTableViewCell"
    
    // MARK: Outlets
    @IBOutlet weak var imageTableFavorites: UIImageView!
    @IBOutlet weak var labelFavorite: UILabel!
    
    // MARK: Overrides
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
}
