import UIKit

class CenterCellCollectionViewFlowLayout: UICollectionViewFlowLayout {
    
    override func targetContentOffset(forProposedContentOffset proposedContentOffset: CGPoint,
                                                              withScrollingVelocity velocity: CGPoint) -> CGPoint {
        if let collectionView = collectionView {
            
            let collectionViewBounds = collectionView.bounds
            let halfWidth = collectionViewBounds.size.width * 0.5
            let proposedContentOffsetCenterX = proposedContentOffset.x + halfWidth
            
            if let attributesForVisibleCells = layoutAttributesForElements(in: collectionViewBounds) {
                
                var candidateAttributes = UICollectionViewLayoutAttributes()
                for attributes in attributesForVisibleCells {
                    
                    // == Skip comparison with non-cell items (headers and footers) == //
                    if attributes.representedElementCategory != UICollectionElementCategory.cell {
                        continue
                    }
                    
                    let a = attributes.center.x - proposedContentOffsetCenterX
                    let b = candidateAttributes.center.x - proposedContentOffsetCenterX
                    
                    if fabsf(Float(a)) < fabsf(Float(b)) {
                        candidateAttributes = attributes
                    }
                }
                
                return CGPoint(x: round(candidateAttributes.center.x - halfWidth), y: proposedContentOffset.y)
            }
        }
        
        return super.targetContentOffset(forProposedContentOffset: proposedContentOffset)
    }
}
