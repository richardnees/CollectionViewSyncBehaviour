import UIKit

final class BackgroundCollectionViewController: SynchronizedCollectionViewController {
    override func reuseIdentifer() -> String {
        return BackgroundCollectionViewCell.reuseIdentifier
    }
    
    override func configure(cell: UICollectionViewCell, indexPath: IndexPath) {
        if let cell = cell as? BackgroundCollectionViewCell {
            cell.uBahnLine = lines[indexPath.row]            
        }
    }
}

extension BackgroundCollectionViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return collectionView.bounds.size
    }
}
