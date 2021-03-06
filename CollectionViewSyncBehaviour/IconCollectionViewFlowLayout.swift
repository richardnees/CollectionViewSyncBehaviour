import UIKit

class IconCollectionViewFlowLayout: CenterCellCollectionViewFlowLayout {

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
            
            var scale = 0.5 + sin(convertedCenterX / collectionViewCenterX)
            scale = max(1.0, scale)
            
            newLayoutAttributes.bounds.size.width = newLayoutAttributes.bounds.size.width * scale
            newLayoutAttributes.bounds.size.height = newLayoutAttributes.bounds.size.height * scale
            
            chagedLayoutAttributes.append(newLayoutAttributes)
        }
        
        return chagedLayoutAttributes
    }
}
