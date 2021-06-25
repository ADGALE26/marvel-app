//
//  DetailViewController.swift
//  MarvelCharacters
//
//  Created by Adrián García Ledesma on 25/6/21.
//

import UIKit

class DetailViewController: UIViewController {
    
    var actualSuperHeroObjet:CharacterResult? = nil

    override func viewDidLoad() {
        super.viewDidLoad()

        title = actualSuperHeroObjet?.name
        
        // Do any additional setup after loading the view.
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        let scrollView = UIScrollView(frame: CGRect(x: 0, y: 0 , width: view.frame.size.width, height: view.frame.size.height))
        view.addSubview(scrollView)
        scrollView.contentSize = CGSize(width: view.frame.size.width, height: 2200)
        
        let heroImage = UIImageView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 300))
        scrollView.addSubview(heroImage)
        heroImage.kf.setImage(with: URL(string: setImage()))
        
        let heroDetail = UILabel(frame: CGRect(x: 0, y: heroImage.frame.size.height, width: view.frame.size.width, height: 20))
        scrollView.addSubview(heroDetail)
        heroDetail.text = actualSuperHeroObjet?.description
        
    }
    
    func setImage()->String{
        
        guard let trustSuperHeroImage = actualSuperHeroObjet?.thumbnail?.path
        else {
            return ""
        }
        let corte = trustSuperHeroImage.firstIndex(of: ":")
        let superHeroImageNoHttp = trustSuperHeroImage[corte!...]
        let superHeroImageHttps = "https" + superHeroImageNoHttp + "." + (actualSuperHeroObjet?.thumbnail?.extensionn ?? "jpg")
        return superHeroImageHttps
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
