//
//  DetailsViewController.swift
//  ProjetoFinal
//
//  Created by Elisa Kalil on 26/10/21.


import UIKit

class DetailsViewController: UIViewController {
    
   
    @IBOutlet weak var viewBlueBackground: UIView!
    @IBOutlet weak var viewYellowBackground: UIView!
    @IBOutlet weak var buttonFavoritar: UIButton!
    @IBOutlet weak var labelNome: UILabel!
    @IBOutlet weak var labelPeso: UILabel!
    @IBOutlet weak var labelAltura: UILabel!
    @IBOutlet weak var labelDescricao: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewBlueBackground.layer.cornerRadius = 100
        
    }

    @IBAction func buttonFavoritar(_ sender: UIButton) {
        
        
    }
        
    }
  
