//
//  SynchronizedScrollingCoordinationBehavior.swift
//  CollectionViewSyncBehaviour
//
//  Created by Richard Nees on 31/10/2016.
//  Copyright © 2016 VIMN. All rights reserved.
//

import UIKit

protocol SynchronizedScrollingCoordination {
    func synchronizedCollectionViewDidScroll(collectionView: UICollectionView)
}

class SynchronizedScrollingCoordinationBehavior: NSObject {
    private(set) var behaviors: [SynchronizedScrollingBehavior] = []
    
    func append(behavior: SynchronizedScrollingBehavior) {
        behavior.coordinator = self
        behaviors.append(behavior)
    }
}

extension SynchronizedScrollingCoordinationBehavior: SynchronizedScrollingCoordination {
    
    func synchronizedCollectionViewDidScroll(collectionView: UICollectionView) {
        let otherCollectionViews = behaviors.map { $0.collectionView }.filter { $0 != collectionView }
        otherCollectionViews.forEach { otherCollectionView in
            let ratio = (otherCollectionView.contentSize.width - otherCollectionView.bounds.width) / (collectionView.contentSize.width - collectionView.bounds.width)
            otherCollectionView.contentOffset.x = (collectionView.contentOffset.x * ratio)
        }
    }
}