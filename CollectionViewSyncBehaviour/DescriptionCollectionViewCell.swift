import UIKit

class DestinationCollectionViewCell: UICollectionViewCell {
    @IBOutlet var titleLabel: UILabel!
    
    static let reuseIdentifier = "DestinationCollectionViewCell"

    var line: UBahnLine? {
        didSet {
            if let line = line {
                backgroundColor = UIColor.clear
                titleLabel.text = line.route.1
                titleLabel.textColor = line.textColor
            }
        }
    }
}
