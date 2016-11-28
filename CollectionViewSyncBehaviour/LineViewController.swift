import UIKit

class LineViewController: UIViewController, UBahnLineSinglePresentable {
    
    var line: UBahnLine? {
        didSet {
            view.backgroundColor = line?.color
            closeButton.tintColor = line?.textColor
            lineNameLabel.textColor = line?.textColor
            lineNameLabel.text = line?.name
            originLabel.textColor = line?.textColor
            originLabel.text = line?.route.0
            destinationLabel.textColor = line?.textColor
            destinationLabel.text = line?.route.1
            spacerView.backgroundColor = line?.textColor
        }
    }
    
    @IBOutlet var closeButton: UIButton!
    @IBOutlet var lineNameLabel: UILabel!
    @IBOutlet var originLabel: UILabel!
    @IBOutlet var destinationLabel: UILabel!
    @IBOutlet var spacerView: UIView!
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        var statusBarStyle = UIStatusBarStyle.default
        if line?.textColor == #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1) {
            statusBarStyle = .lightContent
        }
        return statusBarStyle
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
