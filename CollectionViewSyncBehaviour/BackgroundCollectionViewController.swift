import UIKit

private let reuseIdentifier = "BackgroundCollectionViewCell"

class BackgroundCollectionViewCell: UICollectionViewCell {
    
}

class BackgroundCollectionViewController: UICollectionViewController {
    
    var lines = UBahnLine.all
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        if
            let collectionView = collectionView,
            let flowLayout = collectionViewLayout as? UICollectionViewFlowLayout {
            
            collectionView.decelerationRate = UIScrollViewDecelerationRateFast
            
            flowLayout.itemSize = collectionView.bounds.size
            flowLayout.minimumInteritemSpacing = 0
            flowLayout.minimumLineSpacing = 0
            flowLayout.sectionInset = UIEdgeInsetsZero
        }
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
        coordinator.syncronizedCollectionViewDidScroll(syncronizedCollectionView)
    }
}
