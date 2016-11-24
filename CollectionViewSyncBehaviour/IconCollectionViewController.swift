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
            layer.borderWidth = 1.0

            if let line = line {
                layer.borderColor = line.textColor.cgColor
                backgroundColor = line.color
                titleLabel.text = line.name
                titleLabel.textColor = line.textColor
            }
        }
    }
}

extension IconCollectionViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 120.0, height: 120.0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        var inset = UIEdgeInsets.zero
        let horizontalInset = collectionView.bounds.width/2 - 60.0
        inset.left = horizontalInset
        inset.right = horizontalInset
        return inset
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 50
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}

final class IconCollectionViewController: SynchronizedCollectionViewController {
    
    override func reuseIdentifer() -> String {
        return "IconCollectionViewCell"
    }
        
    override func configure(cell: UICollectionViewCell, indexPath: IndexPath) {
        (cell as? IconCollectionViewCell)?.line = lines[indexPath.row]
    }

    // MARK: UICollectionViewDelegate

    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        synchronizedScrollingBehavior.coordinator?.synchronizeSelection(collectionView)
    }
}
