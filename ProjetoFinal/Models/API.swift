//
//  API.swift
//  ProjetoFinal
//
//  Created by Marilise Morona on 26/10/21.
//

import Foundation

struct API {
    
    // MARK: Properties
    let baseURL = "https://pokeapi.co/api/v2"

    // MARK: Methods
    /// Returns the URL string to EndPoint list of Pokemons
    func setListPokemonURL() -> String {
        return "\(baseURL)/\(EndPoint.pokemon)"
    }
    
    /// Returns the URL string to EndPoint Pokemon
    func setPokemonURL(_ id: Int) -> String {
        return "\(baseURL)/\(EndPoint.pokemon)/\(id)"
    }
    
    func getListPokemons(urlString: String, method: HTTPMethod, response: @escaping (Pokemons) -> Void, errorReturned: @escaping (String) -> Void) {
        let config: URLSessionConfiguration = .default
        let session: URLSession = URLSession(configuration: config)
        guard let url: URL = URL(string: urlString) else { return }
        var urlRequest: URLRequest = URLRequest(url: url)
        urlRequest.httpMethod = "\(method)"
        let task = session.dataTask(with: urlRequest, completionHandler: { (result, urlResponse, error) in
            var statusCode: Int = 0
            if let response = urlResponse as? HTTPURLResponse {
                statusCode = response.statusCode
            }
            guard let data = result else { return }
            do {
                let decoder: JSONDecoder = JSONDecoder()
                let list = try decoder.decode(ListPokemon.self, from: data)
                var poks = Pokemons(poks: [])
                for item in list.results {
                    if let url = item.url {
                        self.getPokemons(urlString: url, method: .GET, response: { pok in
                            poks.poks?.append(pok)
                        }, errorReturned: { erro in
                            print(erro)
                        })
                    }
                }
                response(poks)
            } catch {
                errorReturned("Não retornou os dados da lista de pokemons.")
            }
        })
        task.resume()
    }
    
    func getPokemons(urlString: String, method: HTTPMethod, response: @escaping (Pokemon) -> Void, errorReturned: @escaping (String) -> Void) {
        let config: URLSessionConfiguration = .default
        let session: URLSession = URLSession(configuration: config)
        guard let url: URL = URL(string: urlString) else { return }
        var urlRequest: URLRequest = URLRequest(url: url)
        urlRequest.httpMethod = "\(method)"
        let task = session.dataTask(with: urlRequest, completionHandler: { (result, urlResponse, error) in
            var statusCode: Int = 0
            if let response = urlResponse as? HTTPURLResponse {
                statusCode = response.statusCode
            }
            guard let data = result else { return }
            do {
                let decoder: JSONDecoder = JSONDecoder()
                response(try decoder.decode(Pokemon.self, from: data))
            } catch {
                errorReturned("Não retornou os dados do pokemon.")
            }
        })
        task.resume()
    }
    
}
