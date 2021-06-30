//
//  TableViewController.swift
//  MarvelCharacters
//
//  Created by Adrián García Ledesma on 23/6/21.
//

import UIKit

class SuperHeroTableView: UITableViewController{
    
    var isPaginating = false
    let client = NetworkClient()
    var listOfSuperHeros:[CharacterResult] = []
    var listOfSuperHerosInCache: [CharacterResult] = []
    var misCells: MCell = MCell(xibName: "HeroCell", idReuse: "HeroCell")
    var misCells2: MCell = MCell(xibName: "LoadingCell", idReuse: "LoadingCell")
    var offset = 0
    var isLoading = false
    var totalSuperHeros = 1493
    var actualSuperHeroTappedIndex = 0
    var actualSuperHeroTappedObjet: CharacterResult? = nil
    var searchWithIsStarted: Bool = false
    var currentSearchString: String = ""
    var stillNotRuningSearchString: Bool = true
  

    //MARK: - Search Controller
    lazy var searchBar: UISearchController = {
        let bar = UISearchController(searchResultsController: nil)
        bar.searchResultsUpdater = self
        bar.searchBar.placeholder = "Search Heros"
        bar.obscuresBackgroundDuringPresentation = false
        return bar
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadMoreData()
        
        tableView.keyboardDismissMode = UIScrollView.KeyboardDismissMode.onDrag
        
        definesPresentationContext = true
    
        self.navigationItem.searchController = searchBar
        
        self.tableView!.register(UINib(nibName: misCells.xibName, bundle: nil), forCellReuseIdentifier: misCells.idReuse)
        self.tableView!.register(UINib(nibName: misCells2.xibName, bundle: nil), forCellReuseIdentifier: misCells2.idReuse)
        
    //MARK: - Functions
    }
    
    private func getData(){
        print("All Heros start")
        
        client.getCharacters(offset: offset) { [self] result in
            switch result {
            case .success(let characters):
                
                guard let trustListOfSuperHeros = characters.data?.results else {return}
                
                offset += trustListOfSuperHeros.count
                
                self.listOfSuperHeros.append(contentsOf: trustListOfSuperHeros)
                
                self.tableView.reloadData()
                self.isLoading = false
                
            case .failure(let error):
                // Mostrar una alerta al usuarios con el errorDescription
                print(error.errorDescription ?? "nada")
                switch error {
                case .serverError(_):
                    // Alerta al usuario que le haga li que sea
                    break
                case .dataError(_):
                    // Redirigir al login
                    break
                case .serializationError(_):
                    // Hacer n allamada al serivodr
                    break
                }
            }
        }
        print("All Heros stop")
    }
    
    private func getData2(nameStartWith: String){
        
        print("Search range start")
        client.getCharactersStartWith(nameStartsWith: nameStartWith, offset: offset) { [self] result in
            switch result {
            case .success(let characters):
                
                guard let trustListOfSuperHeros = characters.data?.results else {return}
                
                self.listOfSuperHeros.append(contentsOf: trustListOfSuperHeros)
                
                self.tableView.reloadData()
                
                self.isLoading = false
                
            case .failure(let error):
                // Mostrar una alerta al usuarios con el errorDescription
                print(error.errorDescription ?? "nada")
                switch error {
                case .serverError(_):
                    // Alerta al usuario que le haga li que sea
                    break
                case .dataError(_):
                    // Redirigir al login
                    break
                case .serializationError(_):
                    // Hacer n allamada al serivodr
                    break
                }
            }
        }
        print("Search range stop")
    }
    
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        
        if offset != totalSuperHeros{
            return 2
        }else {
            return 1
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0{
            //Return the amount of items
            return listOfSuperHeros.count
            
        } else if section == 1 {
            //Return the Loading cell
            return 1
            
        } else {
            //Return nothing
            return 0
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: misCells.idReuse, for: indexPath) as! HeroCell
            
            let superHero = listOfSuperHeros[indexPath.row] //indexPath.row nos dice la posicion por la que va
            
            cell.setData(superHero: superHero)
            
            cell.tapAction = {
                self.actualSuperHeroTappedIndex = indexPath.row
                self.SearchForSuperHero()
                self.performSegue(withIdentifier: "detailSegue", sender: self)
            }
            
            return cell
            
        }else{
            
            let cell = tableView.dequeueReusableCell(withIdentifier: misCells2.idReuse, for: indexPath) as! LoadingCell
            
            cell.loading.startAnimating()
            
            return cell
        }
    }
    
    func SearchForSuperHero (){
        for i in 0...listOfSuperHeros.count-1{
            if actualSuperHeroTappedIndex == i{
                actualSuperHeroTappedObjet = listOfSuperHeros[i]
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let detailView = segue.destination as! DetailViewController
        detailView.actualSuperHeroObjet = actualSuperHeroTappedObjet
    }
    
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        let scrollViewActualHeight = scrollView.contentOffset.y
        let tableSize = tableView.contentSize.height
        let scrollFrameSize = scrollView.frame.size.height
        
        if (scrollViewActualHeight > tableSize - scrollFrameSize - 400)  && !isLoading && offset < totalSuperHeros{ //Con isloading evitamos que nos haga tantas llamadas como tarde en pintar los nuevos datos.
            
            if searchWithIsStarted{
                isLoading = true
                getData2(nameStartWith: currentSearchString)
            }
            
            if stillNotRuningSearchString{
                loadMoreData()
            }
        }
    }
    
    func loadMoreData() {
        if !self.isLoading {
            self.isLoading = true
            getData()
            
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 99
        }
        return 45
    }
}
struct MCell {
    var xibName: String
    var idReuse: String
}

extension SuperHeroTableView: UISearchResultsUpdating {
  func updateSearchResults(for searchController: UISearchController) {
    // TODO
    
    guard let trustSearchBarText = searchController.searchBar.text else {return}
    
    if trustSearchBarText != ""{
        listOfSuperHerosInCache = listOfSuperHeros
        stillNotRuningSearchString = false
        currentSearchString = trustSearchBarText
        searchWithIsStarted = true
        listOfSuperHeros.removeAll()
        offset = 0
        getData2(nameStartWith: trustSearchBarText)
        tableView.reloadData()
    }else{
        print("cargando vacio...")
        //tableView.reloadData()
        //loadMoreData()
    }
    
  }

}
