//
//  InitialViewController.swift
//  ProjetoFinal
//
//  Created by Rayana Prata Neves on 21/10/21.
//

import UIKit

class InitialViewController: UIViewController {
    
    @IBOutlet weak var buttonInitial: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
    }
    
    func setupUI (){
        
        buttonInitial.layer.cornerRadius = 12
        navigationController?.navigationBar.tintColor = .black
            
    }
    
    
    @IBAction func handlerInitialButton(_ sender: UIButton) {
        
        let viewController = HomeViewController()
        
        navigationController?.pushViewController(viewController, animated: true)
    }
    
}
