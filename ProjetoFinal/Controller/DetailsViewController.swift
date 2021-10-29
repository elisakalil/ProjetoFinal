//
//  DetailsViewController.swift
//  ProjetoFinal
//
//  Created by Elisa Kalil on 26/10/21.

import UIKit
import Kingfisher

class DetailsViewController: UIViewController {
    
    // MARK: Properties
    var selectedPokemon: Pokemon?
    
    // MARK: Outlets
    @IBOutlet weak var viewBlueBackground: UIView!
    @IBOutlet weak var viewYellowBackground: UIView!
    @IBOutlet weak var buttonFavoritar: UIButton!
    @IBOutlet weak var labelNome: UILabel!
    @IBOutlet weak var labelPeso: UILabel!
    @IBOutlet weak var labelAltura: UILabel!
    @IBOutlet weak var labelDescricao: UILabel!
    @IBOutlet weak var imagePokemon: UIImageView!
    
    // MARK: Overrides
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    // MARK: Actions
    @IBAction func buttonFavoritar(_ sender: UIButton) {
        let context = DataBaseController.persistentContainer.viewContext
        let fav = Favoritos(context: context)
        fav.pokename = selectedPokemon?.name?.capitalized
        fav.pokeimage = selectedPokemon?.sprites?.front_default
        fav.pokealtura = Float(selectedPokemon?.height ?? 0)
        fav.pokepeso = Float(selectedPokemon?.weight ?? 0)
        DataBaseController.saveContext()
        let viewController = FavoriteViewController()
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    // MARK: Methods
    private func setupUI() {
        guard let weight = selectedPokemon?.weight else { return }
        guard let height = selectedPokemon?.height else { return }
        self.title = selectedPokemon?.name?.capitalized
        self.labelNome.text = selectedPokemon?.name?.capitalized
        self.labelPeso.text = "\(weight) g"
        self.labelAltura.text = "\(height) cm"
        if let imageURL = selectedPokemon?.sprites?.front_default {
            if let url = URL(string: imageURL) {
                imagePokemon.kf.setImage(with: url,
                                         options: [.cacheOriginalImage],
                                         completionHandler: { result in })
            }
        }
        viewBlueBackground.layer.cornerRadius = 100
    }
    
}
