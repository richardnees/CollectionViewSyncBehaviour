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
        
        allLayoutAttributes?.forEach { layoutAttributes in            
            var convertedCenterX = collectionView.convert(layoutAttributes.center, to: nil).x
            if convertedCenterX > collectionViewCenterX {
                convertedCenterX = collectionViewWidth - convertedCenterX
            }
            
            var scale = 1.2 - (convertedCenterX / collectionViewCenterX)
            scale = 0.5 + sin(convertedCenterX / collectionViewCenterX)
            
            layoutAttributes.transform = CGAffineTransform(scaleX: scale, y: scale)
        }
        return allLayoutAttributes
    }
    
}
