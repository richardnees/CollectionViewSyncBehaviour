import UIKit

open class SynchronizedCollectionViewController: UICollectionViewController {

    // MARK: Model
    
    var lines = UBahnLine.all

    // MARK: Synchronized Scrolling
    
    @IBOutlet open var synchronizedScrollingBehavior: SynchronizedScrollingBehavior!
    
    open override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateLayout()
    }
    
    open override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        
        coordinator.animate(alongsideTransition: { (context) in
            self.updateLayout()
            
            if let selectedIndexPath = self.behavior.coordinator?.focusedIndexPath {
                self.behavior.coordinator?.scroll(to: selectedIndexPath, animated: false)
            }
        }) { (context) in
        }
    }
    
    func updateLayout() {
        // For subclasses to implement
    }
    
    // MARK: UICollectionViewDataSource
    
    open func reuseIdentifer() -> String {
        return "Cell"
    }
    
    override open func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override open func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return lines.count
    }
    
    override open func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifer(), for: indexPath)
        configure(cell: cell, indexPath: indexPath)
        return cell
    }

    func configure(cell: UICollectionViewCell, indexPath: IndexPath) {
        // For subclasses to implement
    }
    
    // MARK: UIScrollViewDelegate
    
    override open func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        behavior.initiatedScrolling = true
    }
    
    override open func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if behavior.initiatedScrolling {
            synchronizedScrollingBehavior.coordinator?.synchronizedCollectionViewDidScroll(synchronizedScrollingBehavior.collectionView)
        }
    }
    
    override open func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        if behavior.initiatedScrolling {
            synchronizedScrollingBehavior.coordinator?.synchronizedCollectionViewDidEndDecelerating(synchronizedScrollingBehavior.collectionView)
        }
        behavior.initiatedScrolling = false
        scrollingDidEnd()
    }
    
    override open func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        synchronizedScrollingBehavior.coordinator?.synchronizedCollectionViewDidEndScrollingAnimation(synchronizedScrollingBehavior.collectionView)
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
