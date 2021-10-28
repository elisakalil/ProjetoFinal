//
//  FavoriteViewController.swift
//  ProjetoFinal
//
//  Created by Rayana Prata Neves on 28/10/21.
//

import UIKit

class FavoriteViewController: UIViewController {

    // MARK: Properties
    var pokemons: [String] = ["Zezinho", "Pikachu", "Sushi"]
    
    // MARK: Outlets
    @IBOutlet weak var tableViewFavorites: UITableView!
    
    // MARK: Overrides
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
    }
    
    // MARK: Methods
    private func setupUI() {
        
        self.tableViewFavorites.dataSource = self
        self.tableViewFavorites.delegate = self
        
        let nib = UINib(nibName: FavoriteTableViewCell.id, bundle: nil)
        self.tableViewFavorites.register(nib, forCellReuseIdentifier: FavoriteTableViewCell.id)
    }

}

extension FavoriteViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
            return UITableViewCell.EditingStyle.delete
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        self.pokemons.remove(at: indexPath.row)
        tableViewFavorites.reloadData()
    }
    
}

extension FavoriteViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pokemons.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: FavoriteTableViewCell.id, for: indexPath) as? FavoriteTableViewCell else { return UITableViewCell() }

        cell.labelFavorite?.text = pokemons[indexPath.row]
        cell.imageTableFavorites.image = UIImage(systemName: "star.fill")
        
        return cell
    }
    
}
