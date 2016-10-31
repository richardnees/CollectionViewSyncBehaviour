import UIKit

private let reuseIdentifier = "DescriptionCollectionViewCell"

class DescriptionCollectionViewCell: UICollectionViewCell {
    @IBOutlet var titleLabel: UILabel!
}

class DescriptionCollectionViewController: UICollectionViewController {

    var lines = UBahnLine.all
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        if
            let collectionView = collectionView,
            let flowLayout = collectionViewLayout as? UICollectionViewFlowLayout {
            
            collectionView.decelerationRate = UIScrollViewDecelerationRateFast
            
            flowLayout.itemSize = CGRectInset(collectionView.bounds, 10, 10).size
            flowLayout.minimumInteritemSpacing = 0
            flowLayout.minimumLineSpacing = 200
            
            let horizontalInset: CGFloat = 10.0
            flowLayout.sectionInset.left = horizontalInset
            flowLayout.sectionInset.right = horizontalInset
            flowLayout.invalidateLayout()
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
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath) as! DescriptionCollectionViewCell
        configure(cell, indexPath: indexPath)
        return cell
    }
    
    func configure(cell: DescriptionCollectionViewCell, indexPath: NSIndexPath) {
        cell.backgroundColor = lines[indexPath.row].color
        cell.layer.shadowOpacity = 0.5
        cell.layer.shadowOffset = CGSize(width: 2, height: 0)
        cell.layer.cornerRadius = 10.0
        cell.layer.borderColor = UIColor.blackColor().CGColor
        cell.layer.borderWidth = 1.0

        cell.titleLabel.text = "\(lines[indexPath.row].route.0)\n⇆\n\(lines[indexPath.row].route.1)"
        cell.titleLabel.textColor = lines[indexPath.row].textColor
    }
    
    // MARK: UIScrollViewDelegate
    
    override func scrollViewDidScroll(scrollView: UIScrollView) {
        coordinator.syncronizedCollectionViewDidScroll(syncronizedCollectionView)
    }
}


