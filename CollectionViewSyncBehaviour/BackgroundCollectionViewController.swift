import UIKit

private let reuseIdentifier = "BackgroundCollectionViewCell"

class BackgroundCollectionViewCell: UICollectionViewCell {
    
}

extension BackgroundCollectionViewController: HasSynchronizedScrolling {
    var behavior: SynchronizedScrollingBehavior {
        return synchronizedScrollingBehavior
    }
}

extension BackgroundCollectionViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        return collectionView.bounds.size
    }

    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAtIndex section: Int) -> UIEdgeInsets {
        return UIEdgeInsetsZero
    }

    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAtIndex section: Int) -> CGFloat {
        return 0
    }

    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAtIndex section: Int) -> CGFloat {
        return 0
    }
}

class BackgroundCollectionViewController: UICollectionViewController {
    
    @IBOutlet var synchronizedScrollingBehavior: SynchronizedScrollingBehavior!
    
    var lines = UBahnLine.all
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView?.decelerationRate = UIScrollViewDecelerationRateFast
    }
    
    override func viewWillTransitionToSize(size: CGSize, withTransitionCoordinator coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransitionToSize(size, withTransitionCoordinator: coordinator)
        collectionViewLayout.invalidateLayout()
    }
    
    // MARK: UICollectionViewDataSource
    
    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return lines.count
    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath) as! BackgroundCollectionViewCell
        configure(cell, indexPath: indexPath)
        return cell
    }
    
    func configure(cell: BackgroundCollectionViewCell, indexPath: NSIndexPath) {
        cell.backgroundColor = lines[indexPath.row].color
    }
    
    // MARK: UIScrollViewDelegate
    
    override func scrollViewDidScroll(scrollView: UIScrollView) {
        synchronizedScrollingBehavior.coordinator?.synchronizedCollectionViewDidScroll(synchronizedScrollingBehavior.collectionView)
    }
}
