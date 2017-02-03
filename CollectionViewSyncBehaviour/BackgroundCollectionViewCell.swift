import UIKit

final class BackgroundCollectionViewCell: UICollectionViewCell {
    
    static let reuseIdentifier = "BackgroundCollectionViewCell"
    @IBOutlet var imageView: UIImageView!

    var uBahnLine: UBahnLine? {
        didSet {
            guard let uBahnLine = uBahnLine else { return }
            backgroundColor = uBahnLine.color
            imageView.image = UIImage(named: uBahnLine.name)
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.image = nil
    }
    
    override var center: CGPoint {
        get {
            return super.center
        }
        set {
            print(center)
            super.center = newValue
        }
    }

}
