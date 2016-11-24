//
//  SynchronizedScrollingBehavior.swift
//  CollectionViewSyncBehaviour
//
//  Created by Richard Nees on 28/10/2016.
//  Copyright © 2016 VIMN. All rights reserved.
//

import UIKit

protocol HasSynchronizedScrolling: UIScrollViewDelegate {
    var behavior: SynchronizedScrollingBehavior { get }
}

public class SynchronizedScrollingBehavior: NSObject {
    @IBInspectable public var linearScrolling: Bool = true
    @IBInspectable public var fastScrollingEnabled: Bool = false {
        didSet {
            collectionView?.decelerationRate = fastScrollingEnabled ? UIScrollViewDecelerationRateFast : UIScrollViewDecelerationRateNormal
        }
    }
    
    @IBOutlet public var collectionView: UICollectionView! {
        didSet {
            collectionView?.decelerationRate = fastScrollingEnabled ? UIScrollViewDecelerationRateFast : UIScrollViewDecelerationRateNormal
        }
    }
    public var coordinator: SynchronizedScrollingCoordinator?
    public var initiatedScrolling: Bool = false
}
