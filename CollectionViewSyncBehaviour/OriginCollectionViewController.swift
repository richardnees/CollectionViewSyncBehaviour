import UIKit

final class OriginCollectionViewController: SynchronizedCollectionViewController {
    
    override func updateLayout() {
        guard
            let collectionView = collectionView,
            let flowLayout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout else {
                return
        }
        
        var inset = UIEdgeInsets.zero
        let horizontalInset: CGFloat = 10.0
        inset.left = horizontalInset
        inset.right = horizontalInset
        flowLayout.sectionInset = inset
        flowLayout.itemSize = collectionView.bounds.insetBy(dx: 10, dy: 10).size
        collectionView.performBatchUpdates(nil, completion: nil)
    }
    
    override func reuseIdentifer() -> String {
        return OriginCollectionViewCell.reuseIdentifier
    }
    
    override func configure(cell: UICollectionViewCell, indexPath: IndexPath) {
        (cell as? OriginCollectionViewCell)?.line = lines[indexPath.row]
    }
}


