import UIKit

public protocol SynchronizedScrollingCoordinatorDelegate {
    func didChange(_ focusedIndexPath: IndexPath)
}

class SynchronizedScrollingCoordinator: NSObject {
    
    var delegate: SynchronizedScrollingCoordinatorDelegate?
    
    var focusedIndexPath = IndexPath(item: 0, section: 0) {
        didSet {
            if oldValue != focusedIndexPath {
                delegate?.didChange(focusedIndexPath)
            }
        }
    }
    
    var behaviors: [SynchronizedScrollingBehavior] = [] {
        didSet {
            behaviors.forEach { $0.coordinator = self }
        }
    }
    
    func synchronizedCollectionViewDidScroll(collectionView: UICollectionView) {
        let otherCollectionViews = behaviors.map { $0.collectionView }.filter { $0 != collectionView }
        otherCollectionViews.forEach { otherCollectionView in
            let otherCollectionViewPositionX = (otherCollectionView?.contentSize.width)! - (otherCollectionView?.bounds.width)!
            let collectionViewPositionX = collectionView.contentSize.width - collectionView.bounds.width
            let ratio = otherCollectionViewPositionX / collectionViewPositionX
            var newContentOffset = otherCollectionView?.contentOffset
            newContentOffset?.x = collectionView.contentOffset.x * ratio
            otherCollectionView?.setContentOffset(newContentOffset!, animated: false)
        }
    }
    
    func synchronizedCollectionViewDidEndDecelerating(collectionView: UICollectionView) {
        let potentiallyFocusedIndexPaths = collectionView.indexPathsForVisibleItems.filter { indexPath in
            guard let layoutAttributes = collectionView.collectionViewLayout.layoutAttributesForItem(at: indexPath) else { return false }
            
            let convertedCenter = collectionView.convert(layoutAttributes.center, to: nil)
            let difference = abs(convertedCenter.x - collectionView.center.x)
            if difference < layoutAttributes.bounds.width/2 {
                return true
            }
            return false
        }
        
        if let indexPath = potentiallyFocusedIndexPaths.first {
            focusedIndexPath = indexPath
        }
    }
    
    func synchronizedCollectionViewDidEndScrollingAnimation(collectionView: UICollectionView) {
        guard let indexPath = collectionView.indexPathsForSelectedItems?.first else { return }
        focusedIndexPath = indexPath
    }
    
    func synchronizeSelection(collectionView: UICollectionView) {
        guard let indexPath = collectionView.indexPathsForSelectedItems?.first else { return }
        focusedIndexPath = indexPath
        select(indexPath, animated: true)
    }
    
    func scroll(to indexPath: IndexPath, animated: Bool) {
        behaviors.forEach { behavior in
            
            if behavior.linearScrolling == true {
                behavior.collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: animated)
            } else {
                // To support the custom layout of the cards collectionVC
                let scrollToRect = scroll(to: indexPath, insideCollectionView: behavior.collectionView)
                behavior.collectionView.scrollRectToVisible(scrollToRect, animated: animated)
            }
        }
        focusedIndexPath = indexPath
    }
    
    
    func scroll(to indexPath: IndexPath, insideCollectionView collectionView: UICollectionView) -> CGRect {
        let offset = CGFloat(indexPath.item) * collectionView.frame.width
        return CGRect(origin: CGPoint(x: offset, y: 0), size: collectionView.frame.size)
    }
    
    func select(_ indexPath: IndexPath, animated: Bool) {
        focusedIndexPath = indexPath
        behaviors.forEach { behavior in
            behavior.collectionView.selectItem(at: indexPath, animated: animated, scrollPosition: .centeredHorizontally)
        }
    }
}
