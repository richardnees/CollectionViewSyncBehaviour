import UIKit

class OriginCollectionViewCell: UICollectionViewCell {
    @IBOutlet var titleLabel: UILabel!
    
    static let reuseIdentifier = "OriginCollectionViewCell"

    var line: UBahnLine? {
        didSet {
            if let line = line {
                backgroundColor = UIColor.clear
                titleLabel.text = line.route.0
                titleLabel.textColor = line.textColor
            }
        }
    }
}
