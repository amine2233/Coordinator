#if canImport(AppKit)
import AppKit

extension RootViewCoordinatorProvider {
    /**
     Add children view controller in rootViewController coordinator

     - Parameters:
        - controller: View controller will add in rootViewController of coordinator
        - bounds: Size of view in view of rootViewController coodrinator
        - completion: completion run after add children view controller
     */
    public func add(controller children: NSViewController, bounds: CGRect? = nil, completion: (() -> Swift.Void)? = nil) {
        // Add Child View Controller
        rootViewController.addChild(children)
        
        // Configure Child View
        children.view.frame = bounds ?? self.rootViewController.view.bounds
        
        // Add Child View as Subview
        rootViewController.view.addSubview(children.view)
        
        // Run closure
        completion?()
    }

    /**
     Remove children view controller in rootViewController

     - Parameters:
        - controller: View controller will removed in rootViewController of coordinator
        - completion: completion run after remove children view controller
     */
    public func remove(controller children: NSViewController, completion: (() -> Swift.Void)? = nil) {
        // Remove Child View From Superview
        children.view.removeFromSuperview()

        // Notify Child View Controller
        children.removeFromParent()

        // Run completion
        completion?()
    }
}

/// Extension for add or remove Coordinator
extension RootViewCoordinator {
    /**
     Attach view of viewController of childrenCoordinator in rootViewController of parentCoordinator,

     - Parameters:
        - to: childrenCoordinator we will add rootViewController in rootViewController of parent coordinator
        - bounds: Size of view in view of rootViewController coodrinator
        - completion: completion run after add children view controller
     */
    public func add(to children: RootViewCoordinator, bounds: CGRect? = nil, completion: (() -> Swift.Void)? = nil)  {
        children.parentRootViewCoordinator = self
        add(coordinator: children)
        add(controller: children.rootViewController, bounds: bounds, completion: completion)
    }

    /**
     Remove rootViewController of coordinator in parent rootViewController coordinator,

     - Parameters:
        - from: childrenCoordinator we will remove rootViewController in rootViewController parent coordinator
        - completion: completion run after add children view controller
     */
    public func remove(from children: RootViewCoordinator, completion: (() -> Swift.Void)? = nil) {
        children.parentRootViewCoordinator = nil
        remove(coordinator: children)
        remove(controller: children.rootViewController, completion: completion)
    }
}
#endif
