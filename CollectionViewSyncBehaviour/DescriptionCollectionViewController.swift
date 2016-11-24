import UIKit

class DescriptionCollectionViewCell: UICollectionViewCell {
    @IBOutlet var titleLabel: UILabel!
    
    var line: UBahnLine? {
        didSet {
            layer.shadowOpacity = 0.5
            layer.shadowOffset = CGSize(width: 2, height: 0)
            layer.cornerRadius = 10.0
            layer.borderWidth = 1.0
            
            if let line = line {
                layer.borderColor = line.textColor.cgColor
                backgroundColor = UIColor.darkText.withAlphaComponent(0.2)
                titleLabel.text = "\(line.route.0)\n⇆\n\(line.route.1)"
                titleLabel.textColor = line.textColor
            }
        }
    }
}

extension DescriptionCollectionViewController: UICollectionViewDelegateFlowLayout {
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
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 400
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}

class DescriptionCollectionViewController: SynchronizedCollectionViewController {
    
    override func reuseIdentifer() -> String {
        return "DescriptionCollectionViewCell"
    }

    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        collectionViewLayout.invalidateLayout()
    }
    
    override func configure(cell: UICollectionViewCell, indexPath: IndexPath) {
        (cell as? DescriptionCollectionViewCell)?.line = lines[indexPath.row]
    }
}


