import UIKit

enum SegueIdentifier: String {
    case embedMain
    case embedIcon
    case embedDescription
    case showLine
}

protocol UBahnLineSinglePresentable {
    var line: UBahnLine? { get set }
}

protocol UBahnLineMultiplePresentable {
    var lines: [UBahnLine] { get set }
    var uBahnLineSelectable: UBahnLineSelectable? { get set }
}

protocol UBahnLineSelectable {
    func didSelect(line: UBahnLine, at indexPath: IndexPath, sender: Any?)
}

class ViewController: UIViewController {

    @IBOutlet var coordinator: SynchronizedScrollingCoordinator!
    
    let lines = UBahnLine.all
    
    override func viewDidLoad() {
        super.viewDidLoad()
        coordinator.delegate = self
   }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        var statusBarStyle = UIStatusBarStyle.default
        if lines[coordinator.focusedIndexPath.row].textColor == #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1) {
            statusBarStyle = .lightContent
        }
        return statusBarStyle
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {        
        if let synchonizedCollectionViewController = segue.destination as? HasSynchronizedScrolling {
            coordinator.behaviors.append(synchonizedCollectionViewController.behavior)
        }
        
        if var uBahnLinePresentable = segue.destination as? UBahnLineMultiplePresentable {
            uBahnLinePresentable.lines = lines
            uBahnLinePresentable.uBahnLineSelectable = self
        }

        if
            var uBahnLinePresentable = segue.destination as? UBahnLineSinglePresentable,
            let indexPath = sender as? IndexPath {
            uBahnLinePresentable.line = lines[indexPath.row]
        }
    }
    
    @IBAction func unwindToViewController (sender: UIStoryboardSegue) {
        dismiss(animated: true) {
            
        }
    }
}

extension ViewController: SynchronizedScrollingCoordinatorDelegate {
    func didChange(focusedIndexPath: IndexPath) {
        UIView.animate(withDuration: 0.25) {
            self.setNeedsStatusBarAppearanceUpdate()
        }
    }
}

extension ViewController: UBahnLineSelectable {
    func didSelect(line: UBahnLine, at indexPath: IndexPath, sender: Any?) {
        performSegue(withIdentifier: SegueIdentifier.showLine.rawValue, sender: indexPath)
    }
}
