import UIKit

enum SegueIdentifier: String {
    case embedMain
    case embedIcon
    case embedDescription
}

class ViewController: UIViewController {

    @IBOutlet var coordinationBehavior: SynchronizedScrollingCoordinator!
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {        
        if let synchonizedCollectionViewController = segue.destination as? HasSynchronizedScrolling {
            coordinationBehavior.behaviors.append(synchonizedCollectionViewController.behavior)
        }
    }
}
