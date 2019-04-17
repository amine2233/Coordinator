#if canImport(AppKit)
import AppKit

/// Extension For NSViewController
extension RootViewCoordinatorProvider {

    
    /// Add children view controller in rootViewController coordinator
    ///
    ///  - Parameters:
    ///     - controller: View controller will add in rootViewController of coordinator
    ///     - bounds: Size of view in view of rootViewController coodrinator
    ///     - completion: completion run after add children view controller
    ///
    public func addChild(_ controller: NSViewController, bounds: CGRect? = nil, completion: (() -> Swift.Void)? = nil) {
        // Add Child View Controller
        rootViewController.addChild(controller)
        
        // Configure Child View
        controller.view.frame = bounds ?? self.rootViewController.view.bounds
        
        // Add Child View as Subview
        rootViewController.view.addSubview(controller.view)
        
        // Run closure
        completion?()
    }

    /// Remove children view controller in rootViewController

    ///  - Parameters:
    ///     - controller: View controller will removed in rootViewController of coordinator
    ///     - completion: completion run after remove children view controller
    ///
    public func removeChild(_ controller: NSViewController, completion: (() -> Swift.Void)? = nil) {
        // Remove Child View From Superview
        controller.view.removeFromSuperview()

        // Notify Child View Controller
        controller.removeFromParent()

        // Run completion
        completion?()
    }
}

/// Extension for add or remove Coordinator
extension RootViewCoordinator {

    
    ///  Attach view of viewController of childrenCoordinator in rootViewController of parentCoordinator,
    ///
    ///  - Parameters:
    ///     - coordinator: childrenCoordinator we will add rootViewController in rootViewController of parent coordinator
    ///         - bounds: Size of view in view of rootViewController coodrinator
    ///         - completion: completion run after add children view controller
    public func addChildCoordinator(_ coordinator: RootViewCoordinator, bounds: CGRect? = nil, completion: (() -> Swift.Void)? = nil)  {
        coordinator.parentRootViewCoordinator = self
        add(coordinator: coordinator)
        addChild(coordinator.rootViewController, bounds: bounds, completion: completion)
    }

    ///  Remove rootViewController of coordinator in parent rootViewController coordinator,
    ///
    ///  - Parameters:
    ///     - coordinator: childrenCoordinator we will remove rootViewController in rootViewController parent coordinator
    ///     - completion: completion run after add children view controller
    ///
    public func removeChildCoordinator(_ coordinator: RootViewCoordinator, completion: (() -> Swift.Void)? = nil) {
        coordinator.parentRootViewCoordinator = nil
        remove(coordinator: coordinator)
        removeChild(coordinator.rootViewController, completion: completion)
    }
}
#endif
