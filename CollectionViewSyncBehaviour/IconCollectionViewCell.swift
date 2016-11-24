import UIKit

final class IconCollectionViewCell: UICollectionViewCell {
    @IBOutlet var titleLabel: UILabel!

    static let reuseIdentifier = "IconCollectionViewCell"

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
