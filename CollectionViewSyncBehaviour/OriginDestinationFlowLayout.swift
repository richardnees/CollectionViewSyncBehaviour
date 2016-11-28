import UIKit

class OriginDestinationFlowLayout: CenterCellCollectionViewFlowLayout {

    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        return true
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        guard let collectionView = collectionView else { return nil }
        
        let collectionViewWidth = collectionView.bounds.width
        let collectionViewCenterX = collectionView.center.x
        
        let allLayoutAttributes = super.layoutAttributesForElements(in: rect)
        var chagedLayoutAttributes: [UICollectionViewLayoutAttributes] = []
        
        allLayoutAttributes?.forEach { layoutAttributes in
            let newLayoutAttributes = layoutAttributes.copy() as! UICollectionViewLayoutAttributes
            
            var convertedCenterX = collectionView.convert(newLayoutAttributes.center, to: nil).x
            if convertedCenterX > collectionViewCenterX {
                convertedCenterX = collectionViewWidth - convertedCenterX
            }
            
            var alpha = sin(convertedCenterX / collectionViewCenterX)
            alpha = max(0.1, alpha)
            newLayoutAttributes.alpha = alpha
            
            chagedLayoutAttributes.append(newLayoutAttributes)
        }

        return chagedLayoutAttributes
    }
}
