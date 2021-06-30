import UIKit

class SerieCollectionController: NSObject, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource{
    
    var seriesList:[SerieThumbnail]
    
    init(seriesList:[SerieThumbnail]) {
        self.seriesList = seriesList
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return seriesList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "serieCell", for: indexPath) as! SerieCellController
        
        cell.setImage(serieImageList: seriesList[indexPath.row])
        
        return cell
    }
    
}
