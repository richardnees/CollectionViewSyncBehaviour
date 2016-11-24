import UIKit

final class BackgroundCollectionViewController: SynchronizedCollectionViewController {
    
    override func updateLayout() {
        guard
            let collectionView = collectionView,
            let flowLayout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout else {
                return
        }
        
        flowLayout.itemSize = self.view.bounds.size
        collectionView.performBatchUpdates(nil, completion: nil)
    }
    
    override func reuseIdentifer() -> String {
        return BackgroundCollectionViewCell.reuseIdentifier
    }
    
    override func configure(cell: UICollectionViewCell, indexPath: IndexPath) {
        (cell as? BackgroundCollectionViewCell)?.backgroundColor = lines[indexPath.row].color
    }
}
