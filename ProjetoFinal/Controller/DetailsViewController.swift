//
//  DetailsViewController.swift
//  ProjetoFinal
//
//  Created by Elisa Kalil on 26/10/21.


import UIKit
import Kingfisher

class DetailsViewController: UIViewController {
    
    ///MARK: Variables
    
    var selectedPokemon: Pokemon? 
    
   
    @IBOutlet weak var viewBlueBackground: UIView!
    @IBOutlet weak var viewYellowBackground: UIView!
    @IBOutlet weak var buttonFavoritar: UIButton!
    @IBOutlet weak var labelNome: UILabel!
    @IBOutlet weak var labelPeso: UILabel!
    @IBOutlet weak var labelAltura: UILabel!
    @IBOutlet weak var labelDescricao: UILabel!
    @IBOutlet weak var imagePokemon: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let weight = selectedPokemon?.weight else {
            return}
        
        guard let height = selectedPokemon?.height else {
            return}

        
        self.title = selectedPokemon?.name?.capitalized
      //  self.labelDescricao.text =
        self.labelNome.text = selectedPokemon?.name?.capitalized
        self.labelPeso.text = "\(Float(weight/100)) kg"
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

    @IBAction func buttonFavoritar(_ sender: UIButton) {
        
        
    }
        
    }
  
