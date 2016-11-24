//
//  IconCollectionViewController.swift
//  CollectionViewSyncBehaviour
//
//  Created by Richard Nees on 27/10/2016.
//  Copyright © 2016 VIMN. All rights reserved.
//

import UIKit

final class IconCollectionViewCell: UICollectionViewCell {
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

final class IconCollectionViewController: SynchronizedCollectionViewController {
    
    override func reuseIdentifer() -> String {
        return "IconCollectionViewCell"
    }
    
    override func viewWillTransitionToSize(size: CGSize, withTransitionCoordinator coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransitionToSize(size, withTransitionCoordinator: coordinator)
        collectionViewLayout.invalidateLayout()
        
        if let selectedIndexPath = collectionView?.indexPathsForVisibleItems().first {
            coordinator.animateAlongsideTransition({ (context) in
                
            }) { (context) in
                self.collectionView?.scrollToItemAtIndexPath(selectedIndexPath, atScrollPosition: .CenteredHorizontally, animated: false)
            }
        }
    }
    
    override func configure(cell: UICollectionViewCell, indexPath: NSIndexPath) {
        (cell as? IconCollectionViewCell)?.line = lines[indexPath.row]
    }

    // MARK: UICollectionViewDelegate

    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        synchronizedScrollingBehavior.coordinator?.synchronizeSelection(collectionView)
    }
}
