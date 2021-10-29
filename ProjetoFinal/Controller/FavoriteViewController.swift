//
//  FavoriteViewController.swift
//  ProjetoFinal
//
//  Created by Rayana Prata Neves on 28/10/21.
//

import UIKit
import Kingfisher

class FavoriteViewController: UIViewController {

    // MARK: Properties
    var fav: [Favoritos] = []
    
    // MARK: Outlets
    @IBOutlet weak var tableViewFavorites: UITableView!
    
    // MARK: Overrides
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.reloadTableViewPokemon()
    }
    
    // MARK: Methods
    
    func reloadTableViewPokemon(){
        do {
            self.fav = try DataBaseController.persistentContainer.viewContext.fetch(Favoritos.fetchRequest())
        } catch {
            print("Não consegui trazer as informações do banco de dados")
        }
        self.tableViewFavorites.reloadData()
    }
    
    private func setupUI() {
        let leftButton = UIBarButtonItem(title: "Voltar", style: .plain, target: self, action: #selector(getHomeViewController))
        self.navigationItem.leftBarButtonItem = leftButton
        
        self.tableViewFavorites.dataSource = self
        self.tableViewFavorites.delegate = self
        
        let nib = UINib(nibName: FavoriteTableViewCell.id, bundle: nil)
        self.tableViewFavorites.register(nib, forCellReuseIdentifier: FavoriteTableViewCell.id)
    }
    
    @objc func getHomeViewController() {
        if let controllers = self.navigationController?.viewControllers {
            for i in (0..<controllers.count).reversed()  {
                if !controllers[i].isKind(of: HomeViewController.self) {
                    self.navigationController?.popViewController(animated: true)
                } else {
                    return
                }
            }
        }
    }
}

extension FavoriteViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
            return UITableViewCell.EditingStyle.delete
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        let poke = fav[indexPath.row]
//        context.delete(poke.pokename)
        let context = DataBaseController.persistentContainer.viewContext
        
        
        if editingStyle == .delete {
            context.delete(poke)
            do{
                try context.save()
            } catch {
                
            }
        
            self.fav.remove(at: indexPath.row)
            tableViewFavorites.reloadData()
        
        }
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let details = DetailsViewController()
        let poke = fav[indexPath.row]
        let pokemonSelecionado : Pokemon = Pokemon(name: poke.pokename, height: Int(poke.pokealtura), weight: Int(poke.pokepeso))
        details.selectedPokemon = pokemonSelecionado
        navigationController?.pushViewController(details, animated: true)
    }
}

extension FavoriteViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fav.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: FavoriteTableViewCell.id, for: indexPath) as? FavoriteTableViewCell else { return UITableViewCell() }

        let poke = fav[indexPath.row]
        
        cell.labelFavorite?.text = poke.pokename
        
        if let imageURL = poke.pokeimage {
            if let url = URL(string: imageURL) {
                cell.imageTableFavorites.kf.setImage(with: url,
                                          options: [.cacheOriginalImage],
                                          completionHandler: { result in })
            }
        
        }
        return cell
    }
    
}
