//
//  API.swift
//  ProjetoFinal
//
//  Created by Marilise Morona on 26/10/21.
//

import Foundation

class API: PokemonAPI {
    
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
    
    func getListPokemons(urlString: String, method: HTTPMethod, success: @escaping (Pokemons) -> Void, failure: @escaping (SGApiError) -> Void) {
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
                let dispatchGroup = DispatchGroup()
                for item in list.results {
                    if let url = item.url {
                        dispatchGroup.enter()
                        self.getPokemons(urlString: url, method: .GET) { pok in
                            poks.poks?.append(pok)
                            dispatchGroup.leave()
                        } failure: { error in
                            dispatchGroup.leave()
                            switch error {
                            case .emptyArray:
                                // Mostrar alerta para o usuário de que nao veio nenhum valor da API
                                // self.showAlertToUser(message: "Não foi possível mostrar os Pokemóns")
                                print("Não foi possível mostrar os Pokemóns")
                            case .notFound:
                                // Mostrar alerta para o usuário dizendo que ele está sem internet ou teve problema na api
                                // self.showAlertToUser(message: "Sem internet, verifique sua conexão com a Internet")
                                print("Sem internet, verifique sua conexão com a Internet")
                            default:
                                break;
                            }
                        }
                        dispatchGroup.wait()
                    }
                    
                }
                
                switch statusCode {
                case 200:
                    success(poks)
                    //failure(SGApiError.notFound)
                case 404:
                    failure(SGApiError.notFound)
                    return
                case 500:
                    failure(SGApiError.serverError)
                    return
                default:
                    break
                }
                
            } catch {
                failure(SGApiError.invalidResponse)
            }
        })
        task.resume()
    }
    
    func getPokemons(urlString: String, method: HTTPMethod, success: @escaping (Pokemon) -> Void, failure: @escaping (SGApiError) -> Void) {
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
                let poke = try decoder.decode(Pokemon.self, from: data)
                
                switch statusCode {
                case 200:
                    success(poke)
                case 404:
                    failure(SGApiError.notFound)
                    return
                case 500:
                    failure(SGApiError.serverError)
                    return
                default:
                    break
                }
                
            } catch {
                failure(SGApiError.invalidResponse)
            }
        })
        task.resume()
    }
    
}
