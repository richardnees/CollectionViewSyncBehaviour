//
//  SynchronizedCollectionViewController.swift
//  CollectionViewSyncBehaviour
//
//  Created by Richard Nees on 24/11/2016.
//  Copyright © 2016 VIMN. All rights reserved.
//

import UIKit

public class SynchronizedCollectionViewController: UICollectionViewController {

    // MARK: Model
    
    var lines = UBahnLine.all

    // MARK: Synchronized Scrolling
    
    @IBOutlet public var synchronizedScrollingBehavior: SynchronizedScrollingBehavior!
    
    // MARK: UICollectionViewDataSource
    
    public func reuseIdentifer() -> String {
        return "Cell"
    }
    
    override public func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override public func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return lines.count
    }
    
    override public func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifer(), forIndexPath: indexPath)
        configure(cell, indexPath: indexPath)
        return cell
    }

    func configure(cell: UICollectionViewCell, indexPath: NSIndexPath) {
        // For subclasses to implement
    }
    
    // MARK: UIScrollViewDelegate
    
    override public func scrollViewWillBeginDragging(scrollView: UIScrollView) {
        behavior.initiatedScrolling = true
    }
    
    override public func scrollViewDidScroll(scrollView: UIScrollView) {
        if behavior.initiatedScrolling {
            synchronizedScrollingBehavior.coordinator?.synchronizedCollectionViewDidScroll(synchronizedScrollingBehavior.collectionView)
        }
    }
    
    override public func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        if behavior.initiatedScrolling {
            synchronizedScrollingBehavior.coordinator?.synchronizedCollectionViewDidEndDecelerating(synchronizedScrollingBehavior.collectionView)
        }
        behavior.initiatedScrolling = false
        scrollingDidEnd()
    }
    
    override public func scrollViewDidEndScrollingAnimation(scrollView: UIScrollView) {
        synchronizedScrollingBehavior.coordinator?.synchronizedCollectionViewDidEndScrollingAnimation(synchronizedScrollingBehavior.collectionView)
        scrollingDidEnd()
    }
    
    func scrollingDidEnd() {
        // For subclasses to implement
    }
}

extension SynchronizedCollectionViewController: HasSynchronizedScrolling {
    var behavior: SynchronizedScrollingBehavior {
        return synchronizedScrollingBehavior
    }
}
