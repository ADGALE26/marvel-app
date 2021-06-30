import UIKit

class  ComicCellController: UICollectionViewCell {
    
    lazy var comicImage: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = true
        view.layer.cornerRadius = 5
        return view
    }()

    override init(frame: CGRect){
        super.init(frame: .zero)
        
        contentView.addSubview(comicImage)
        setConstraints()
    
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setConstraints(){
        var constraints = [NSLayoutConstraint]()
    
        constraints.append(comicImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor))
        constraints.append(comicImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor))
        constraints.append(comicImage.topAnchor.constraint(equalTo: contentView.topAnchor))
        constraints.append(comicImage.bottomAnchor.constraint(equalTo: contentView.bottomAnchor))
        
        NSLayoutConstraint.activate(constraints)
    }
    
    func setImage(comicImageList:ComicThumnail){
        
        guard let trustComicImage = comicImageList.path else {return}
        let corte = trustComicImage.firstIndex(of: ":")
        let comicImageNoHttp = trustComicImage[corte!...]
        let comicHttps = "https" + comicImageNoHttp + "." + (comicImageList.extensionn ?? "jpg")
        
        comicImage.kf.setImage(with: URL(string: comicHttps))
    }
}
