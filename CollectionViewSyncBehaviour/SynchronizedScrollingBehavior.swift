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

open class SynchronizedScrollingBehavior: NSObject {
    @IBInspectable open var linearScrolling: Bool = true
    @IBInspectable open var fastScrollingEnabled: Bool = false {
        didSet {
            collectionView?.decelerationRate = fastScrollingEnabled ? UIScrollViewDecelerationRateFast : UIScrollViewDecelerationRateNormal
        }
    }
    
    @IBOutlet open var collectionView: UICollectionView! {
        didSet {
            collectionView?.decelerationRate = fastScrollingEnabled ? UIScrollViewDecelerationRateFast : UIScrollViewDecelerationRateNormal
        }
    }
    open var coordinator: SynchronizedScrollingCoordinator?
    open var initiatedScrolling: Bool = false
}
