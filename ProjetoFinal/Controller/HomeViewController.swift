
//  HomeViewController.swift
//  ProjetoFinal
//  Created by Elisa Kalil on 21/10/21.

import UIKit

class HomeViewController: UIViewController {

    let api = API()
    var listPokemon: ListPokemon?
    
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
            listPokemonCollectionView.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.84),

        ])
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.view.addSubview(listPokemonCollectionView)
        createConstrains()
        let nib = UINib(nibName: PokemonCollectionViewCell.id, bundle: nil)
        
        listPokemonCollectionView.register(nib, forCellWithReuseIdentifier: PokemonCollectionViewCell.id)

        let url = api.setListPokemonURL()
        api.getListPokemons(urlString: url, method: .GET) { pokemonReturn in
            self.listPokemon = pokemonReturn
            DispatchQueue.main.async {
                guard let list = self.listPokemon else { return }
                print("Quantidade de pokemons \(list.results.count)")
                self.listPokemonCollectionView.reloadData()
            }
        } errorReturned: { error in
            print("\(error)")
        }
    }
}

extension HomeViewController: UICollectionViewDelegate {

    
}

extension HomeViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let list = self.listPokemon {
            return list.results.count
        }else {
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let pokemon = listPokemon!.results[indexPath.row]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PokemonCollectionViewCell.id, for: indexPath) as! PokemonCollectionViewCell
        
        cell.labelPokemon.text = pokemon.name?.capitalized
        print(pokemon)
        return cell
    }
    
    
}

