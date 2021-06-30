//
//  NetworkClient.swift
//  MarvelCharacters
//
//  Created by Adrián García Ledesma on 22/6/21.
//

import Alamofire
import  Foundation

class NetworkClient {

    private let baseUrl = "https://gateway.marvel.com"
    private let comicsOrSeriesPath = "/v1/public/characters/"
    
    //MARK: -Charater Requests
    private let charactersPath = "/v1/public/characters"
    
    private lazy var CharacterTimeSpam: Int = {
        return Int(Date().timeIntervalSince1970)
    }()
    
    private lazy var CharacterHash:String = {
        md5Hash("\(CharacterTimeSpam)\(privateKey)\(publicKey)")
    }()
    
    
    func getCharacters(offset: Int, completion: @escaping (Result<CharacterResponse, NetworkError>) -> Void) {
        AF.request(
            "\(baseUrl)\(charactersPath)",
            method: .get,
            parameters: [
                "apikey": publicKey,
                "hash": CharacterHash,
                "ts": CharacterTimeSpam,
                "limit": 50,
                "offset": offset //cada vez que hacemos una llamada este parametro aumenta de limit en limit para tener una rango de elementos a traer.
            ]
        ).validate(statusCode: 200 ..< 299).responseJSON { serverResponse in
            guard serverResponse.error == nil else {
                completion(.failure(.serverError("Ha ocurrido algun error: \(serverResponse.error?.localizedDescription ?? "")")))
                return
            }
            guard let secureData = serverResponse.data else {
                completion(.failure(.dataError("Ha ocurrido algun error y los datos no existen")))
                return
            }
            do {
                let json = try JSONDecoder().decode(CharacterResponse.self, from: secureData)
                completion(.success(json))
            } catch {
                completion(.failure(.serializationError("Error: \(error.localizedDescription)")))
                return
            }
        }
    }
    
    //MARK: - Character request start with
    
    func getCharactersStartWith(nameStartsWith: String, offset: Int, completion: @escaping (Result<CharacterResponse, NetworkError>) -> Void) {
        AF.request(
            "\(baseUrl)\(charactersPath)",
            method: .get,
            parameters: [
                "apikey": publicKey,
                "hash": CharacterHash,
                "ts": CharacterTimeSpam,
                "limit": 50,
                "nameStartsWith": nameStartsWith,
                "offset": offset
            ]
        ).validate(statusCode: 200 ..< 299).responseJSON { serverResponse in
            guard serverResponse.error == nil else {
                completion(.failure(.serverError("Ha ocurrido algun error: \(serverResponse.error?.localizedDescription ?? "")")))
                return
            }
            guard let secureData = serverResponse.data else {
                completion(.failure(.dataError("Ha ocurrido algun error y los datos no existen")))
                return
            }
            do {
                let json = try JSONDecoder().decode(CharacterResponse.self, from: secureData)
                completion(.success(json))
            } catch {
                completion(.failure(.serializationError("Error: \(error.localizedDescription)")))
                return
            }
        }
    }
    //MARK: -Comic Requests
    private lazy var ComicTimeSpam: Int = {
        return Int(Date().timeIntervalSince1970)
    }()
    
    private lazy var comicHash:String = {
        md5Hash("\(ComicTimeSpam)\(privateKey)\(publicKey)")
    }()

    

    func getComics(characterId: Int, completion: @escaping (Result<ComicResponse, NetworkError>) -> Void) {
        AF.request(
            "\(baseUrl)\(comicsOrSeriesPath)\(characterId)/comics",
            method: .get,
            parameters: [
                "apikey": publicKey,
                "hash": comicHash,
                "ts": ComicTimeSpam,
                "characterId": characterId,
                //"limit": 5,
                //"offset": offset //cada vez que hacemos una llamada este parametro aumenta de limit en limit para tener una rango de elementos a traer.
            ]
        ).validate(statusCode: 200 ..< 299).responseJSON { serverResponse in
            guard serverResponse.error == nil else {
                completion(.failure(.serverError("Ha ocurrido algun error: \(serverResponse.error?.localizedDescription ?? "")")))
                return
            }
            guard let secureData = serverResponse.data else {
                completion(.failure(.dataError("Ha ocurrido algun error y los datos no existen")))
                return
            }
            do {
                let json = try JSONDecoder().decode(ComicResponse.self, from: secureData)
                completion(.success(json))
            } catch {
                completion(.failure(.serializationError("Error: \(error.localizedDescription)")))
                return
            }
        }
    }
    
    //MARK: -Serie Requests
    private lazy var SerieTimeSpam: Int = {
        return Int(Date().timeIntervalSince1970)
    }()
    
    private lazy var serieHash:String = {
        md5Hash("\(SerieTimeSpam)\(privateKey)\(publicKey)")
    }()

    

    func getSeries(characterId: Int, completion: @escaping (Result<SerieResponse, NetworkError>) -> Void) {
        AF.request(
            "\(baseUrl)\(comicsOrSeriesPath)\(characterId)/series",
            method: .get,
            parameters: [
                "apikey": publicKey,
                "hash": serieHash,
                "ts": SerieTimeSpam,
                //"characterId": characterId,
                //"limit": 5,
                //"offset": offset //cada vez que hacemos una llamada este parametro aumenta de limit en limit para tener una rango de elementos a traer.
            ]
        ).validate(statusCode: 200 ..< 299).responseJSON { serverResponse in
            guard serverResponse.error == nil else {
                completion(.failure(.serverError("Ha ocurrido algun error: \(serverResponse.error?.localizedDescription ?? "")")))
                return
            }
            guard let secureData = serverResponse.data else {
                completion(.failure(.dataError("Ha ocurrido algun error y los datos no existen")))
                return
            }
            do {
                let json = try JSONDecoder().decode(SerieResponse.self, from: secureData)
                completion(.success(json))
            } catch {
                completion(.failure(.serializationError("Error: \(error.localizedDescription)")))
                return
            }
        }
    }
}

enum NetworkError: Error, LocalizedError {
    case serverError(String)
    case dataError(String)
    case serializationError(String)

    public var errorDescription: String? {
        switch self {
        case .serverError(let descrition):
            return descrition
        case .dataError(let descrition):
            return descrition
        case .serializationError(let descrition):
            return descrition
        }
    }
}


