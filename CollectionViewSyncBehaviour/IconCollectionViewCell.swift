import UIKit

final class IconCollectionViewCell: UICollectionViewCell {
    @IBOutlet var titleLabel: UILabel!

    static let reuseIdentifier = "IconCollectionViewCell"

    var line: UBahnLine? {
        didSet {
            layer.masksToBounds = false
            layer.shadowColor = UIColor.black.withAlphaComponent(0.5).cgColor
            layer.shadowOpacity = 0.0
            layer.shadowRadius = 10.0
            layer.shadowOffset = CGSize(width: 0, height: 0)
            layer.cornerRadius = 10.0
            layer.borderWidth = 1.0
            
            updateShadow()

            if let line = line {
                layer.borderColor = line.textColor.cgColor
                backgroundColor = line.color
                titleLabel.text = line.name
                titleLabel.textColor = line.textColor
            }
        }
    }
    
    func updateShadow() {
        let scale = Float(bounds.size.width) - 120
        layer.shadowOpacity = scale / 10.0
    }
    
    override var bounds: CGRect {
        get {
            return super.bounds
        }
        set {
            updateShadow()
            super.bounds = newValue
        }
    }
}
