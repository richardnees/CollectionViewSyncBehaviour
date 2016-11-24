//
//  SynchronizedScrollingCoordinator.swift
//  CollectionViewSyncBehaviour
//
//  Created by Richard Nees on 31/10/2016.
//  Copyright © 2016 VIMN. All rights reserved.
//

import UIKit

public protocol SynchronizedScrollingCoordinatorDelegate {
    func didChange(focusedIndexPath: NSIndexPath)
}

public class SynchronizedScrollingCoordinator: NSObject {
    
    public var delegate: SynchronizedScrollingCoordinatorDelegate?
    
    public var focusedIndexPath: NSIndexPath = NSIndexPath(forItem: 0, inSection: 0) {
        didSet {
            if oldValue != focusedIndexPath {
                delegate?.didChange(focusedIndexPath)
            }
        }
    }
    
    public var behaviors: [SynchronizedScrollingBehavior] = [] {
        didSet {
            behaviors.forEach { $0.coordinator = self }
        }
    }
    
    public func synchronizedCollectionViewDidScroll(collectionView: UICollectionView) {
        let otherCollectionViews = behaviors.map { $0.collectionView }.filter { $0 != collectionView }
        otherCollectionViews.forEach { otherCollectionView in
            let otherCollectionViewPositionX = otherCollectionView.contentSize.width - otherCollectionView.bounds.width
            let collectionViewPositionX = collectionView.contentSize.width - collectionView.bounds.width
            let ratio = otherCollectionViewPositionX / collectionViewPositionX
            var newContentOffset = otherCollectionView.contentOffset
            newContentOffset.x = collectionView.contentOffset.x * ratio
            otherCollectionView.setContentOffset(newContentOffset, animated: false)
        }
    }
    
    public func synchronizedCollectionViewDidEndDecelerating(collectionView: UICollectionView) {
        let potentiallyFocusedIndexPaths = collectionView.indexPathsForVisibleItems().filter { indexPath in
            guard let layoutAttributes = collectionView.collectionViewLayout.layoutAttributesForItemAtIndexPath(indexPath) else { return false }
            
            let convertedCenter = collectionView.convertPoint(layoutAttributes.center, toView: nil)
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
    
    public func synchronizedCollectionViewDidEndScrollingAnimation(collectionView: UICollectionView) {
        guard let indexPath = collectionView.indexPathsForSelectedItems()?.first else { return }
        focusedIndexPath = indexPath
    }
    
    public func synchronizeSelection(collectionView: UICollectionView) {
        guard let indexPath = collectionView.indexPathsForSelectedItems()?.first else { return }
        focusedIndexPath = indexPath
        select(indexPath, animated: true)
    }
    
    public func scroll(to indexPath: NSIndexPath, animated: Bool) {
        behaviors.forEach { behavior in
            
            if behavior.linearScrolling == true {
                behavior.collectionView.scrollToItemAtIndexPath(indexPath, atScrollPosition: .CenteredHorizontally, animated: animated)
            } else {
                // To support the custom layout of the cards collectionVC
                let scrollToRect = scrollToRectWithIndexPath(indexPath, insideCollectionView: behavior.collectionView)
                behavior.collectionView.scrollRectToVisible(scrollToRect, animated: animated)
            }
        }
        focusedIndexPath = indexPath
    }
    
    
    public func scrollToRectWithIndexPath(indexPath: NSIndexPath, insideCollectionView collectionView: UICollectionView) -> CGRect {
        let offset = CGFloat(indexPath.item) * collectionView.frame.width
        return CGRect(origin: CGPoint(x: offset, y: 0), size: collectionView.frame.size)
    }
    
    public func select(indexPath: NSIndexPath, animated: Bool) {
        focusedIndexPath = indexPath
        behaviors.forEach { behavior in
            behavior.collectionView.selectItemAtIndexPath(indexPath, animated: animated, scrollPosition: .CenteredHorizontally)
        }
    }
}
