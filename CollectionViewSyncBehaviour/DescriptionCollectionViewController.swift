import UIKit

class DescriptionCollectionViewCell: UICollectionViewCell {
    @IBOutlet var titleLabel: UILabel!
    
    var line: UBahnLine? {
        didSet {
            layer.shadowOpacity = 0.5
            layer.shadowOffset = CGSize(width: 2, height: 0)
            layer.cornerRadius = 10.0
            layer.borderColor = UIColor.blackColor().CGColor
            layer.borderWidth = 1.0
            
            if let line = line {
                backgroundColor = line.color
                titleLabel.text = "\(line.route.0)\n⇆\n\(line.route.1)"
                titleLabel.textColor = line.textColor
            }
        }
    }
}

extension DescriptionCollectionViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        return CGRectInset(collectionView.bounds, 10, 10).size
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAtIndex section: Int) -> UIEdgeInsets {
        var inset = UIEdgeInsetsZero
        let horizontalInset: CGFloat = 10.0
        inset.left = horizontalInset
        inset.right = horizontalInset
        return inset
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAtIndex section: Int) -> CGFloat {
        return 400
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAtIndex section: Int) -> CGFloat {
        return 0
    }
}

class DescriptionCollectionViewController: SynchronizedCollectionViewController {
    
    override func reuseIdentifer() -> String {
        return "DescriptionCollectionViewCell"
    }

    override func viewWillTransitionToSize(size: CGSize, withTransitionCoordinator coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransitionToSize(size, withTransitionCoordinator: coordinator)
        collectionViewLayout.invalidateLayout()
    }
    
    override func configure(cell: UICollectionViewCell, indexPath: NSIndexPath) {
        (cell as? DescriptionCollectionViewCell)?.line = lines[indexPath.row]
    }
}


