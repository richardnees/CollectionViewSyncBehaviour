import UIKit

class SynchronizedCollectionViewController: UICollectionViewController, UBahnLineMultiplePresentable {

    // MARK: Model
    
    var lines: [UBahnLine] = []
    var uBahnLineSelectable: UBahnLineSelectable?
    
    // MARK: Synchronized Scrolling
    
    @IBOutlet var synchronizedScrollingBehavior: SynchronizedScrollingBehavior!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        
        coordinator.animate(alongsideTransition: { (context) in
            self.collectionViewLayout.invalidateLayout()
            
            if let selectedIndexPath = self.behavior.coordinator?.focusedIndexPath {
                self.behavior.coordinator?.scroll(to: selectedIndexPath, animated: false)
            }
        }) { (context) in
        }
    }
    
    // MARK: UICollectionViewDataSource
    
    func reuseIdentifer() -> String {
        return "Cell"
    }
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return lines.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifer(), for: indexPath)
        configure(cell: cell, indexPath: indexPath)
        return cell
    }

    func configure(cell: UICollectionViewCell, indexPath: IndexPath) {
        // For subclasses to implement
    }
    
    // MARK: UIScrollViewDelegate
    
    override func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        behavior.initiatedScrolling = true
    }
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if behavior.initiatedScrolling {
            synchronizedScrollingBehavior.coordinator?.synchronizedCollectionViewDidScroll(collectionView: synchronizedScrollingBehavior.collectionView)
        }
    }
    
    override func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        if behavior.initiatedScrolling {
            synchronizedScrollingBehavior.coordinator?.synchronizedCollectionViewDidEndDecelerating(collectionView: synchronizedScrollingBehavior.collectionView)
        }
        behavior.initiatedScrolling = false
        scrollingDidEnd()
    }
    
    override func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        synchronizedScrollingBehavior.coordinator?.synchronizedCollectionViewDidEndScrollingAnimation(collectionView: synchronizedScrollingBehavior.collectionView)
        scrollingDidEnd()
    }
    
    func scrollingDidEnd() {
        // For subclasses to implement
    }
}

extension SynchronizedCollectionViewController: HasSynchronizedScrolling {
    var behavior: SynchronizedScrollingBehavior {
        return synchronizedScrollingBehavior
    }
}
