//
//  SyncronizedScrollingBehavior.swift
//  CollectionViewSyncBehaviour
//
//  Created by Richard Nees on 28/10/2016.
//  Copyright © 2016 VIMN. All rights reserved.
//

import UIKit

protocol SyncronizedScrollingCoordination {
    var viewController: UIViewController { get }
    func syncronizedCollectionViewDidScroll(collectionView: UICollectionView)
}

protocol SyncronizedScrollable {
    var syncronizedCollectionView: UICollectionView { get }
    var coordinator: SyncronizedScrollingCoordination { get }
}

class SyncronizedScrollingBehavior: NSObject {

}

extension UICollectionViewController: SyncronizedScrollable {
    
    var syncronizedCollectionView: UICollectionView {
        return collectionView!
    }
    
    var coordinator: SyncronizedScrollingCoordination {
        return parentViewController as! SyncronizedScrollingCoordination
    }
}