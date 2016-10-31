import UIKit

enum SegueIdentifier: String {
    case embedMain
    case embedIcon
    case embedDescription
}

class ViewController: UIViewController {

    var synchonizedCollectionViewsControllers: [SyncronizedScrollable] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        print(synchonizedCollectionViewsControllers)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {        
        if let synchonizedCollectionViewController = segue.destinationViewController as? SyncronizedScrollable {
            synchonizedCollectionViewsControllers.append(synchonizedCollectionViewController)
        }
    }
}

extension ViewController: SyncronizedScrollingCoordination {
    
    var viewController: UIViewController {
        return self
    }
    
    func syncronizedCollectionViewDidScroll(collectionView: UICollectionView) {
        
        let otherCollectionViews = synchonizedCollectionViewsControllers.map { $0.syncronizedCollectionView }.filter { $0 != collectionView }
        otherCollectionViews.forEach { otherCollectionView in
            let ratio = (otherCollectionView.contentSize.width - otherCollectionView.bounds.width) / (collectionView.contentSize.width - collectionView.bounds.width)
            otherCollectionView.contentOffset.x = (collectionView.contentOffset.x * ratio)
        }
    }
}

