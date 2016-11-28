import UIKit

final class IconCollectionViewCell: UICollectionViewCell {
    @IBOutlet var titleLabel: UILabel!

    static let reuseIdentifier = "IconCollectionViewCell"

    var line: UBahnLine? {
        didSet {
            layer.masksToBounds = false
            layer.shadowColor = UIColor.black.cgColor
            layer.shadowOpacity = 0.5
            layer.shadowOffset = CGSize(width: 0, height: 2)
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
