
//  HomeViewController.swift
//  ProjetoFinal
//  Created by Elisa Kalil on 21/10/21.

import UIKit
import Kingfisher
import Lottie

class HomeViewController: UIViewController {

    // MARK: Properties
    var api: PokemonAPI?
    var animateView = AnimationView(name: "loading")
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
    
    convenience init(api: PokemonAPI) {
        self.init()
        self.api = api
    }
    
    // MARK: Overrides
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        requestAPI()
    }
    
    // MARK: Methods
    private func setupUI() {
        createRightBarButton()
        self.view.addSubview(listPokemonCollectionView)
        createConstrains()
        
        let nib = UINib(nibName: PokemonCollectionViewCell.id, bundle: nil)
        listPokemonCollectionView.register(nib, forCellWithReuseIdentifier: PokemonCollectionViewCell.id)
    }
    
    private func createRightBarButton() {
        let starImage = UIImage(systemName: "star.fill")
        let rightButton = UIBarButtonItem(image: starImage, style: UIBarButtonItem.Style.plain, target: self, action: #selector(getFavorites))
        rightButton.tintColor = UIColor(red: 1.00, green: 0.80, blue: 0.14, alpha: 0.55)
        self.navigationItem.rightBarButtonItem = rightButton
    }
    
    @objc func getFavorites() {
        //To do: validar se tem algum dado no core data, se nao tiver apresentar um alerta para o usuario
        //informando que deve primeiro favoritar um pokemon
        let viewController = FavoriteViewController()
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    private func requestAPI() {
        
        addLoading()
        
        guard let api = self.api else {return}
        let url = api.setListPokemonURL()
        api.getListPokemons(urlString: url, method: .GET) { pokemonReturn in
                        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                            self.animateView.pause() // pausa a animacao
                            self.animateView.isHidden = true // esconde da tela
                            self.animateView.removeFromSuperview() //remove da tela
                            
                            self.listPokemon = pokemonReturn
                            self.listPokemonCollectionView.reloadData()
                        }
//                        DispatchQueue.main.async {
//                            self.listPokemon = pokemonReturn
//                            self.listPokemonCollectionView.reloadData()
//                        }
        } failure: { error in
            switch error {
            case .emptyArray:
                // Mostrar alerta para o usuário informando que nao veio nenhum valor da API
                self.showAlertToUser(message: "Não foi possível mostrar os Pokemóns")
            case .notFound:
                // Mostrar alerta para o usuário informando que ele está sem internet ou teve problema na api
                self.showAlertToUser(message: "Sem internet")
            default:
                break;
            }
        }
        
    }
    
    private func addLoading() {
        self.view.addSubview(animateView)
        animateView.loopMode = .loop
        let posX = (UIScreen.main.bounds.width - 240)/2
        let posY = (UIScreen.main.bounds.height - 120)/2
        animateView.frame = CGRect(x: posX, y: posY, width: 240, height: 120)
        
        animateView.isHidden = false
        animateView.alpha = 0.8
        animateView.play()
    }
    
    private func showAlertToUser(message: String) {
        let alert = UIAlertController(title: "Atenção", message: message, preferredStyle: .alert)
        let buttoRedoCall = UIAlertAction(title: "Tentar Novamente", style: .cancel) { _ in
            self.requestAPI()
        }
        let buttonCancel = UIAlertAction(title: "Cancelar", style: .destructive, handler: nil)
        alert.addAction(buttoRedoCall)
        alert.addAction(buttonCancel)
        DispatchQueue.main.async {
            self.present(alert, animated: true, completion: nil)
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
