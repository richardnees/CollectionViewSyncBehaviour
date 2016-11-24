import UIKit

final class BackgroundCollectionViewCell: UICollectionViewCell {
    
}

extension BackgroundCollectionViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return collectionView.bounds.size
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets.zero
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}

final class BackgroundCollectionViewController: SynchronizedCollectionViewController {
    
    override func reuseIdentifer() -> String {
        return "BackgroundCollectionViewCell"
    }
    
    override func configure(cell: UICollectionViewCell, indexPath: IndexPath) {
        (cell as? BackgroundCollectionViewCell)?.backgroundColor = lines[indexPath.row].color
    }
}
