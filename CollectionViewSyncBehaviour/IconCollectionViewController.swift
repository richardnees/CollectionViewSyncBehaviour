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
}

class IconCollectionViewController: UICollectionViewController {
    
    var lines = UBahnLine.all
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        if
            let collectionView = collectionView,
            let flowLayout = collectionViewLayout as? CenterCellCollectionViewFlowLayout {
            
            collectionView.decelerationRate = UIScrollViewDecelerationRateFast
            
            flowLayout.itemSize = CGSize(width: 120.0, height: 120.0)
            flowLayout.minimumInteritemSpacing = 0
            flowLayout.minimumLineSpacing = 50
            
            let horizontalInset = collectionView.bounds.width/2 - 60.0
            flowLayout.sectionInset.left = horizontalInset
            flowLayout.sectionInset.right = horizontalInset
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
        cell.backgroundColor = lines[indexPath.row].color
        cell.layer.shadowOpacity = 0.5
        cell.layer.shadowOffset = CGSize(width: 2, height: 0)
        cell.layer.cornerRadius = 10.0
        cell.layer.borderColor = UIColor.blackColor().CGColor
        cell.layer.borderWidth = 1.0
        
        cell.titleLabel.text = lines[indexPath.row].name
        cell.titleLabel.textColor = lines[indexPath.row].textColor
    }

    // MARK: UICollectionViewDelegate

    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        collectionView.scrollToItemAtIndexPath(indexPath, atScrollPosition: .CenteredHorizontally, animated: true)
    }
    
    // MARK: UIScrollViewDelegate
    
    override func scrollViewDidScroll(scrollView: UIScrollView) {
        coordinator.syncronizedCollectionViewDidScroll(syncronizedCollectionView)
    }
}

