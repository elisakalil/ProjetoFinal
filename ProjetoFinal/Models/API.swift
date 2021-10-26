//
//  API.swift
//  ProjetoFinal
//
//  Created by Marilise Morona on 26/10/21.
//

import Foundation

struct API{
    let baseURL = "https://pokeapi.co/api/v2"

    ///Returns the URL string to EndPoint list of Pokemons
    func setListPokemonURL() -> String {
        return "\(baseURL)/\(EndPoint.pokemon)"
    }
    
    func setPokemonURL(_ id: Int) -> String {
        return "\(baseURL)/\(EndPoint.pokemon)/\(id)"
    }
    
    func getListPokemons(urlString: String, method: HTTPMethod, response: @escaping (ListPokemon) -> Void, errorReturned: @escaping (String) -> Void){
        let config: URLSessionConfiguration = .default
        let session: URLSession = URLSession(configuration: config)
        guard let url: URL = URL(string: urlString) else { return }
        var urlRequest: URLRequest = URLRequest(url: url)
        urlRequest.httpMethod = "\(method)"
        let task = session.dataTask(with: urlRequest, completionHandler: { (result, urlResponse, error) in
            var statusCode: Int = 0
            if let response = urlResponse as? HTTPURLResponse {
                statusCode = response.statusCode
                print(statusCode)
            }
            guard let data = result else { return }
            do {
                let decoder: JSONDecoder = JSONDecoder()
                response(try decoder.decode(ListPokemon.self, from: data))
            }catch{
                errorReturned("Não retornou os dados.")
            }
        })
        task.resume()
    }
    
}


