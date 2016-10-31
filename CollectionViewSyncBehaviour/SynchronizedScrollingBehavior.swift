//
//  SynchronizedScrollingBehavior.swift
//  CollectionViewSyncBehaviour
//
//  Created by Richard Nees on 28/10/2016.
//  Copyright © 2016 VIMN. All rights reserved.
//

import UIKit

protocol HasSynchronizedScrolling {
    var behavior: SynchronizedScrollingBehavior { get }
}

class SynchronizedScrollingBehavior: NSObject {
    @IBOutlet var collectionView: UICollectionView!
    var coordinator: SynchronizedScrollingCoordination?
}
