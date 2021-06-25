//
//  HeroCell.swift
//  MarvelCharacters
//
//  Created by Adrián García Ledesma on 23/6/21.
//

import UIKit
import Kingfisher

class HeroCell: UITableViewCell {

    @IBOutlet weak var superHeroImage: UIImageView!
    @IBOutlet weak var superHeroName: UILabel!
    @IBOutlet weak var superHeroDescription: UILabel!
    var tapAction : (()->())?
    
    @IBAction func goToDetail (_ sender: Any){
        tapAction?()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    
    func setData(superHero:CharacterResult){
        superHeroDescription.text = superHero.description
        superHeroName.text = superHero.name
        superHeroImage.layer.cornerRadius = 7
        guard let trustSuperHeroImage = superHero.thumbnail?.path else {return}
        let corte = trustSuperHeroImage.firstIndex(of: ":")
        let superHeroImageNoHttp = trustSuperHeroImage[corte!...]
        let superHeroImageHttps = "https" + superHeroImageNoHttp + "." + (superHero.thumbnail?.extensionn ?? "jpg")
        
        superHeroImage.kf.setImage(with: URL(string: superHeroImageHttps))
        
        
    }

    /*override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }*/
    
}
