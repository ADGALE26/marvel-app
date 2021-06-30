//
//  DetailViewController.swift
//  MarvelCharacters
//
//  Created by Adrián García Ledesma on 25/6/21.
//

import UIKit

class DetailViewController: UIViewController{

    var actualSuperHeroObjet:CharacterResult? = nil
    //var actualComicsArray:[ComicResult] = []
    //var actualSeriesArray:[SerieResult] = []
    var characterId:Int = 0
    let client = NetworkClient()
    //var offset:Int = 0
    var isLoading:Bool = false
    
    
    // MARK: - Properties
    lazy var contentViewSize = CGSize(width: view.frame.width, height: view.frame.height + 800)
    
    // MARK: - Views
    lazy var scrollView: UIScrollView = {
        let  view = UIScrollView(frame: .zero)
        view.frame = self.view.bounds
        view.contentSize = contentViewSize
        return view
    }()
    
    lazy var containerView: UIView = {
        let view = UIView()
        view.frame.size = contentViewSize
        return view
    }()
    
    lazy var heroImageView: UIImageView = {
        let view = UIImageView()
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var heroDescription: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    //MARK: - Comic Title
    
    lazy var comicTitle: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.text = "Comics"
        setTitleProperties(title: view)
        return view
    }()
    
    //MARK: - Comic ScrollView
     lazy var comicCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 20
        layout.itemSize = CGSize(width: (containerView.frame.width / 2) - 15, height: 300 - 22)
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear
        view.register(ComicCellController.self, forCellWithReuseIdentifier: "comicCell")
        view.delegate = self.comicDataAndDelegate
        view.dataSource = self.comicDataAndDelegate
        return view
        
    }()
    
    //MARK: -Comic Collection Controller
    lazy var comicDataAndDelegate: ComicCollectionController = {
        let controller = ComicCollectionController(comicsList: [])
        return controller
    }()
    
    //MARK: - Serie Title
    lazy var serieTitle: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.text = "Series"
        setTitleProperties(title: view)
        return view
    }()
    
    //MARK: - Series ScrollView
    lazy var seriesCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 20
        layout.itemSize = CGSize(width: (containerView.frame.width / 1.4) - 15, height: 300 - 22)
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear
        view.register(SerieCellController.self, forCellWithReuseIdentifier: "serieCell")
        view.delegate = self.serieDataAndDelegate
        view.dataSource = self.serieDataAndDelegate
        return view
    }()
    
    //MARK: -Comic Collection Controller
    lazy var serieDataAndDelegate: SerieCollectionController = {
        let controller = SerieCollectionController(seriesList: [])
        return controller
    }()
    
    //MARK: - Event Title
    lazy var eventTitle: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.text = "Events"
        setTitleProperties(title: view)
        return view
    }()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        title = actualSuperHeroObjet?.name
        
        view.addSubview(scrollView)
        scrollView.addSubview(containerView)
        containerView.addSubview(heroImageView)
        containerView.addSubview(heroDescription)
        containerView.addSubview(comicTitle)
        containerView.addSubview(comicCollectionView)
        containerView.addSubview(serieTitle)
        containerView.addSubview(seriesCollectionView)
        containerView.addSubview(eventTitle)
        
        setConstraints()
        
        setImageAndProperties()
        setDescriptionProperties()
        
        checkId()
    }
    
    

    
    // MARK: - Functions
    
    private func setConstraints(){
        var constraints = [NSLayoutConstraint]()
        
        // Add
        constraints.append(heroImageView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor))
        constraints.append(heroImageView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor))
        constraints.append(heroImageView.topAnchor.constraint(equalTo: containerView.topAnchor))
        constraints.append(heroImageView.heightAnchor.constraint(equalToConstant: 280))
        
        constraints.append(heroDescription.leadingAnchor.constraint(equalTo: heroImageView.leadingAnchor, constant: 16))
        constraints.append(heroDescription.trailingAnchor.constraint(equalTo: heroImageView.trailingAnchor, constant: -16))
        constraints.append(heroDescription.topAnchor.constraint(equalTo: heroImageView.bottomAnchor, constant: 15))
        
        constraints.append(comicTitle.leadingAnchor.constraint(equalTo: heroDescription.leadingAnchor))
        constraints.append(comicTitle.trailingAnchor.constraint(equalTo: heroDescription.trailingAnchor))
        constraints.append(comicTitle.topAnchor.constraint(equalTo: heroDescription.bottomAnchor, constant: 20))
        
        constraints.append(comicCollectionView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 10))
        constraints.append(comicCollectionView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor))
        constraints.append(comicCollectionView.topAnchor.constraint(equalTo: comicTitle.bottomAnchor, constant: 7))
        constraints.append(comicCollectionView.heightAnchor.constraint(equalToConstant: 300))
        
        constraints.append(serieTitle.leadingAnchor.constraint(equalTo: heroDescription.leadingAnchor))
        constraints.append(serieTitle.trailingAnchor.constraint(equalTo: heroDescription.trailingAnchor))
        constraints.append(serieTitle.topAnchor.constraint(equalTo: comicCollectionView.bottomAnchor, constant: 15))
        
        constraints.append(seriesCollectionView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 10))
        constraints.append(seriesCollectionView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor))
        constraints.append(seriesCollectionView.topAnchor.constraint(equalTo: serieTitle.bottomAnchor, constant: 7))
        constraints.append(seriesCollectionView.heightAnchor.constraint(equalToConstant: 300))
        
        constraints.append(eventTitle.leadingAnchor.constraint(equalTo: seriesCollectionView.leadingAnchor))
        constraints.append(eventTitle.trailingAnchor.constraint(equalTo: seriesCollectionView.trailingAnchor))
        constraints.append(eventTitle.topAnchor.constraint(equalTo: seriesCollectionView.bottomAnchor, constant: 20))
        
        NSLayoutConstraint.activate(constraints)
        
    }
    
    private func setImageAndProperties(){
        heroImageView.kf.setImage(with: URL(string: convertImageUrl()))
        heroImageView.contentMode = .scaleAspectFill
    }
    
    private func setDescriptionProperties(){
        heroDescription.numberOfLines = 0
        heroDescription.text = actualSuperHeroObjet?.description
        heroDescription.font = UIFont(name: "Arial", size: 21)
        heroDescription.setLineHeight(lineHeight: 7)
        
    }
    
    private func setTitleProperties(title:UILabel){
        title.numberOfLines = 1
        title.font = UIFont(name: "Arial-BoldMT", size: 30)
        
    }
    func convertImageUrl()->String{
        
        guard let trustSuperHeroImage = actualSuperHeroObjet?.thumbnail?.path
        else {
            return ""
        }
        let corte = trustSuperHeroImage.firstIndex(of: ":")
        let superHeroImageNoHttp = trustSuperHeroImage[corte!...]
        let superHeroImageHttps = "https" + superHeroImageNoHttp + "." + (actualSuperHeroObjet?.thumbnail?.extensionn ?? "jpg")
        return superHeroImageHttps
    }
    
    func checkId(){
        guard let trustCharacterId = actualSuperHeroObjet?.id else {return}
        characterId = trustCharacterId
        
        requestDataComic()
        requestDataSerie()
    }
    
   //MARK: - thread Request Comic
    
    private func requestDataComic(){
        
        print("Empieza")
        
        client.getComics(characterId: characterId){ [self] result in
            switch result {
            case .success(let comics):
                
                guard let trustListOfComics = comics.data?.results else {return}
 
                    //self.actualComicsArray = trustListOfComics
                
                if trustListOfComics.count != 0 {
                    for i in 0...trustListOfComics.count - 1{
                        guard let trustThumnail = trustListOfComics[i].thumbnail else {return}
                        self.comicDataAndDelegate.comicsList.append(trustThumnail)
                    }
                }
                
                //self.comicDataAndDelegate.comicsList = actualComicsArray
                
                self.comicCollectionView.reloadData()
        
                //self.isLoading = false
                
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
        
        print("Acaba")
    }
    
    //MARK: - thread Request Serie
    
    private func requestDataSerie(){
        
        print("Empieza")
        
        client.getSeries(characterId: characterId){ [self] result in
            switch result {
            case .success(let series):
                
                guard let trustListOfSeries = series.data?.results else {return}

                //self.actualComicsArray = trustListOfComics
                
                if trustListOfSeries.count != 0 {
                    for i in 0...trustListOfSeries.count - 1{
                        guard let trustThumbnail = trustListOfSeries[i].thumbnail else {return}
                        self.serieDataAndDelegate.seriesList.append(trustThumbnail)
                    }
                }
                
                //self.comicDataAndDelegate.comicsList = actualComicsArray
                
                self.seriesCollectionView.reloadData()
                
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
        
        print("Acaba")
    }
}
