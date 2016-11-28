import UIKit

final class OriginCollectionViewController: SynchronizedCollectionViewController {
    override func reuseIdentifer() -> String {
        return OriginCollectionViewCell.reuseIdentifier
    }
    
    override func configure(cell: UICollectionViewCell, indexPath: IndexPath) {
        (cell as? OriginCollectionViewCell)?.line = lines[indexPath.row]
    }
}

extension OriginCollectionViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return collectionView.bounds.insetBy(dx: 10, dy: 10).size
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        var inset = UIEdgeInsets.zero
        let horizontalInset: CGFloat = 10.0
        inset.left = horizontalInset
        inset.right = horizontalInset
        return inset
    }
}
