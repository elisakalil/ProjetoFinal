//
//  InitialViewController.swift
//  ProjetoFinal
//
//  Created by Rayana Prata Neves on 21/10/21.
//

import UIKit

class InitialViewController: UIViewController {
    
    // MARK: Outlets
    @IBOutlet weak var buttonInitial: UIButton!
    
    // MARK: Overrides
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    // MARK: Actions
    @IBAction func handlerInitialButton(_ sender: UIButton) {
        let viewController = HomeViewController(api: API())
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    // MARK: Methods
    func setupUI (){
        buttonInitial.layer.cornerRadius = 12
        navigationController?.navigationBar.tintColor = .black
    }
    
}
