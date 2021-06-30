//
//  SerieCellController.swift
//  MarvelCharacters
//
//  Created by Adrián García Ledesma on 28/6/21.
//

import UIKit

class SerieCellController: UICollectionViewCell {
    
    lazy var serieImage: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = true
        view.layer.cornerRadius = 5
        return view
    }()

    override init(frame: CGRect){
        super.init(frame: .zero)
        
        contentView.addSubview(serieImage)
        setConstraints()
    
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setConstraints(){
        var constraints = [NSLayoutConstraint]()
    
        constraints.append(serieImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor))
        constraints.append(serieImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor))
        constraints.append(serieImage.topAnchor.constraint(equalTo: contentView.topAnchor))
        constraints.append(serieImage.bottomAnchor.constraint(equalTo: contentView.bottomAnchor))
        
        NSLayoutConstraint.activate(constraints)
    }
    
    func setImage(serieImageList:SerieThumbnail){
        
        guard let trustSerieImage = serieImageList.path else {return}
        let corte = trustSerieImage.firstIndex(of: ":")
        let serieImageNoHttp = trustSerieImage[corte!...]
        let serieHttps = "https" + serieImageNoHttp + "." + (serieImageList.extensionn ?? "jpg")
        
        serieImage.kf.setImage(with: URL(string: serieHttps))
    }
}

