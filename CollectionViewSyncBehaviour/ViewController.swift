import UIKit

enum SegueIdentifier: String {
    case embedMain
    case embedIcon
    case embedDescription
}

class ViewController: UIViewController {

    @IBOutlet var coordinationBehavior: SynchronizedScrollingCoordinator!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print(coordinationBehavior.behaviors)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {        
        if let synchonizedCollectionViewController = segue.destination as? HasSynchronizedScrolling {
            coordinationBehavior.behaviors.append(synchonizedCollectionViewController.behavior)
        }
    }
}
