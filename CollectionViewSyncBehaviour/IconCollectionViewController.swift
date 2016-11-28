import UIKit

final class IconCollectionViewController: SynchronizedCollectionViewController {
    override func reuseIdentifer() -> String {
        return IconCollectionViewCell.reuseIdentifier
    }
        
    override func configure(cell: UICollectionViewCell, indexPath: IndexPath) {
        (cell as? IconCollectionViewCell)?.line = lines[indexPath.row]
    }

    // MARK: UICollectionViewDelegate

    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath == synchronizedScrollingBehavior.coordinator?.focusedIndexPath {
            uBahnLineSelectable?.didSelect(line: lines[indexPath.row], at: indexPath, sender: self)
        }
        synchronizedScrollingBehavior.coordinator?.synchronizeSelection(collectionView: collectionView)
    }
}

extension IconCollectionViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        var inset = UIEdgeInsets.zero
        let horizontalInset = collectionView.bounds.width/2 - 60.0
        inset.left = horizontalInset
        inset.right = horizontalInset
        return inset
    }
}
