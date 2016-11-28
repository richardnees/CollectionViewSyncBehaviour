import UIKit

final class BackgroundCollectionViewController: SynchronizedCollectionViewController {
    override func reuseIdentifer() -> String {
        return BackgroundCollectionViewCell.reuseIdentifier
    }
    
    override func configure(cell: UICollectionViewCell, indexPath: IndexPath) {
        (cell as? BackgroundCollectionViewCell)?.backgroundColor = lines[indexPath.row].color
    }
}

extension BackgroundCollectionViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return collectionView.bounds.size
    }
}
