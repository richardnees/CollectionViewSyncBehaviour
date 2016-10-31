import UIKit

enum SegueIdentifier: String {
    case embedMain
    case embedIcon
    case embedDescription
}

class ViewController: UIViewController {

    @IBOutlet var coordinationBehavior: SynchronizedScrollingCoordinationBehavior!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        print(coordinationBehavior.behaviors)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {        
        if let synchonizedCollectionViewController = segue.destinationViewController as? HasSynchronizedScrolling {
            coordinationBehavior.append(synchonizedCollectionViewController.behavior)
        }
    }
}
