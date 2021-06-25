//
//  ViewController.swift
//  MarvelCharacters
//
//  Created by Adrián García Ledesma on 22/6/21.
//

import UIKit

class ViewController: UIViewController {
    
    //let client = NetworkClient()
    //var ListOfSuperHeros:[CharacterResult] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        /*print("Empieza")
        
        client.getCharacters { result in
            switch result {
            case .success(let characters):
                
                guard let trustListOfSuperHeros = characters.data?.results else {return}
                self.ListOfSuperHeros = trustListOfSuperHeros
                
                //print(characters.data?.results?.first as Any)
                //Refrescar la UITableview
                //self.tableview.reloadData
            case .failure(let error):
                // Mostrar una alerta al usuarios con el errorDescription
                print(error.errorDescription)
                switch error {
                case .serverError(let description):
                    // Alerta al usuario que le haga li que sea
                    break
                case .dataError(let description):
                    // Redirigir al login
                    break
                case .serializationError(let description):
                    // Hacer n allamada al serivodr
                    break
                }
            }
        }
        
        print("Acaba")*/
    }
    
}

