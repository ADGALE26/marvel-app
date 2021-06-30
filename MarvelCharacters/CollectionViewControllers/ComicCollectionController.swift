import UIKit

class ComicCollectionController: NSObject, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource{
    
    var comicsList:[ComicThumnail]
    
    init(comicsList:[ComicThumnail]) {
        self.comicsList = comicsList
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return comicsList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "comicCell", for: indexPath) as! ComicCellController
        
        cell.setImage(comicImageList: comicsList[indexPath.row])
        
        return cell
    }
    
}
