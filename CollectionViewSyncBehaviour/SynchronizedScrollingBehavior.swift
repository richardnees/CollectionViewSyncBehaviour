import UIKit

protocol HasSynchronizedScrolling {
    var behavior: SynchronizedScrollingBehavior { get }
}

class SynchronizedScrollingBehavior: NSObject {
    @IBInspectable var linearScrolling: Bool = true
    @IBInspectable var fastScrollingEnabled: Bool = false {
        didSet {
            collectionView?.decelerationRate = fastScrollingEnabled ? UIScrollViewDecelerationRateFast : UIScrollViewDecelerationRateNormal
        }
    }
    
    @IBOutlet var collectionView: UICollectionView! {
        didSet {
            collectionView?.decelerationRate = fastScrollingEnabled ? UIScrollViewDecelerationRateFast : UIScrollViewDecelerationRateNormal
        }
    }
    var coordinator: SynchronizedScrollingCoordinator?
    var initiatedScrolling: Bool = false
}
