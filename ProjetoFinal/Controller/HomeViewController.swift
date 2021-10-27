
//  HomeViewController.swift
//  ProjetoFinal
//  Created by Elisa Kalil on 21/10/21.

import UIKit
import Kingfisher

class HomeViewController: UIViewController {

    // MARK: Properties
    let api = API()
    var listPokemon =  Pokemons(poks: [])
    var pokemon: Pokemon?
    
    lazy var listPokemonCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let heightCell:CGFloat = (self.view.frame.width/2.0-40)
        layout.itemSize = CGSize(width: heightCell, height: heightCell)
        layout.minimumInteritemSpacing = 10
        layout.minimumLineSpacing = 10
        layout.scrollDirection = .vertical

        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .clear
        
        return collectionView
    }()
    
    fileprivate func createConstrains() {
        NSLayoutConstraint.activate([
            listPokemonCollectionView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 20),
            listPokemonCollectionView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            listPokemonCollectionView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            listPokemonCollectionView.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.84)
        ])
    }
    
    // MARK: Overrides
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        requestAPI()
    }
    
    // MARK: Methods
    private func setupUI() {
        self.view.addSubview(listPokemonCollectionView)
        createConstrains()
        
        let nib = UINib(nibName: PokemonCollectionViewCell.id, bundle: nil)
        listPokemonCollectionView.register(nib, forCellWithReuseIdentifier: PokemonCollectionViewCell.id)
    }
    
    private func requestAPI() {
        let url = api.setListPokemonURL()
        api.getListPokemons(urlString: url, method: .GET) { pokemonReturn in
            
            DispatchQueue.main.async {
                self.listPokemon = pokemonReturn
                self.listPokemonCollectionView.reloadData()
            }
        } errorReturned: { error in
            print("\(error)")
        }
    }
    
}

extension HomeViewController: UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let details = DetailsViewController()
        guard let poks = self.listPokemon.poks else { return }
        details.selectedPokemon = poks[indexPath.row]
        navigationController?.pushViewController(details, animated: true)
    }
    
}

extension HomeViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let poks = self.listPokemon.poks {
            return poks.count
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return self.displayPokemon(collectionView: collectionView, indexPath: indexPath)
    }
    
    func displayPokemon(collectionView: UICollectionView, indexPath: IndexPath) -> PokemonCollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PokemonCollectionViewCell.id, for: indexPath) as! PokemonCollectionViewCell
        guard let poks = self.listPokemon.poks else { return cell }
        
        if let pok = poks[indexPath.row] as? Pokemon {
            cell.labelPokemon.text = pok.name?.capitalized ?? "Pokemon sem nome"
            if let imageURL = pok.sprites?.front_default {
                if let url = URL(string: imageURL) {
                    cell.imagePokemon.kf.setImage(
                        with: url,
                        options: [.cacheOriginalImage],
                        completionHandler: { result in })
                }
            }
        }
        return cell
    }
    
}
