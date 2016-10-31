//
//  IconCollectionViewController.swift
//  CollectionViewSyncBehaviour
//
//  Created by Richard Nees on 27/10/2016.
//  Copyright © 2016 VIMN. All rights reserved.
//

import UIKit

private let reuseIdentifier = "IconCollectionViewCell"

class IconCollectionViewCell: UICollectionViewCell {
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
                titleLabel.text = line.name
                titleLabel.textColor = line.textColor
            }
        }
    }
}

extension IconCollectionViewController: HasSynchronizedScrolling {
    var behavior: SynchronizedScrollingBehavior {
        return synchronizedScrollingBehavior
    }
}

extension IconCollectionViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        return CGSize(width: 120.0, height: 120.0)
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAtIndex section: Int) -> UIEdgeInsets {
        var inset = UIEdgeInsetsZero
        let horizontalInset = collectionView.bounds.width/2 - 60.0
        inset.left = horizontalInset
        inset.right = horizontalInset
        return inset
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAtIndex section: Int) -> CGFloat {
        return 50
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAtIndex section: Int) -> CGFloat {
        return 0
    }
}

class IconCollectionViewController: UICollectionViewController {
    
    @IBOutlet var synchronizedScrollingBehavior: SynchronizedScrollingBehavior!

    var lines = UBahnLine.all
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView?.decelerationRate = UIScrollViewDecelerationRateFast
    }
    
    override func viewWillTransitionToSize(size: CGSize, withTransitionCoordinator coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransitionToSize(size, withTransitionCoordinator: coordinator)
        collectionViewLayout.invalidateLayout()
        
        if let selectedIndexPath = collectionView?.indexPathsForSelectedItems()?.first {
            coordinator.animateAlongsideTransition({ (context) in
                
            }) { (context) in
                self.collectionView?.scrollToItemAtIndexPath(selectedIndexPath, atScrollPosition: .CenteredHorizontally, animated: false)
                self.synchronizedScrollingBehavior.coordinator?.synchronizedCollectionViewDidScroll(self.synchronizedScrollingBehavior.collectionView)
            }
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
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath) as! IconCollectionViewCell
        configure(cell, indexPath: indexPath)
        return cell
    }
    
    func configure(cell: IconCollectionViewCell, indexPath: NSIndexPath) {
        cell.line = lines[indexPath.row]
    }

    // MARK: UICollectionViewDelegate

    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        collectionView.scrollToItemAtIndexPath(indexPath, atScrollPosition: .CenteredHorizontally, animated: true)
    }
    
    // MARK: UIScrollViewDelegate
    
    override func scrollViewDidScroll(scrollView: UIScrollView) {
        synchronizedScrollingBehavior.coordinator?.synchronizedCollectionViewDidScroll(synchronizedScrollingBehavior.collectionView)
    }
}

