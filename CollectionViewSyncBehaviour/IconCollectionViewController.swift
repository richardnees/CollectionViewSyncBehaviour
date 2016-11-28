import UIKit

final class IconCollectionViewController: SynchronizedCollectionViewController {
        
    override func updateLayout() {
        guard
            let collectionView = collectionView,
            let flowLayout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout else {
                return
        }
        
        var inset = UIEdgeInsets.zero
        let horizontalInset = collectionView.bounds.width/2 - 60.0
        inset.left = horizontalInset
        inset.right = horizontalInset
        flowLayout.sectionInset = inset
        collectionView.performBatchUpdates(nil, completion: nil)
    }
    
    override func reuseIdentifer() -> String {
        return IconCollectionViewCell.reuseIdentifier
    }
        
    override func configure(cell: UICollectionViewCell, indexPath: IndexPath) {
        (cell as? IconCollectionViewCell)?.line = lines[indexPath.row]
    }

    // MARK: UICollectionViewDelegate

    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        synchronizedScrollingBehavior.coordinator?.synchronizeSelection(collectionView: collectionView)
    }
}
