#if canImport(UIKit)
import UIKit

#if !os(watchOS)

/// Extension for add UIViewController in container
extension RootViewCoordinatorProvider {
    
    
    /// Add children view controller in rootViewController coordinator
    ///
    ///  - Parameters:
    ///     - children: View controller will add in rootViewController of coordinator
    ///     - bounds: Size of view in view of rootViewController coodrinator
    ///     - completion: completion run after add children view controller
    public func addChild(_ controller: UIViewController, bounds: CGRect? = nil, completion: (() -> Swift.Void)? = nil) {
        // Add Child View Controller
        rootViewController.addChild(controller)
        
        // Configure Child View
        controller.view.frame = bounds ?? rootViewController.view.bounds
        controller.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        // Add Child View as Subview
        rootViewController.view.addSubview(controller.view)
        
        // Notify Child View Controller
        controller.didMove(toParent: rootViewController)
        
        // Run closure
        completion?()
    }

    /// Remove children view controller in rootViewController
    ///
    /// - Parameters:
    ///    - children: View controller will removed in rootViewController of coordinator
    ///    - completion: completion run after remove children view controller
    public func removeChild(_ controller: UIViewController, completion: (() -> Swift.Void)? = nil) {
        // Notify Child View Controller
        controller.willMove(toParent: rootViewController)
        
        // Notify Child View Controller
        controller.removeFromParent()
        
        // Remove Child View From Superview
        controller.view.removeFromSuperview()
        
        // Run Closure
        completion?()
    }
}

/// Extension for UIViewController
extension RootViewCoordinatorProvider {
    
    /// Present view controller in rootViewController of coordinator
    ///
    /// - Parameters:
    ///    - controller: View controller will add in rootViewController of coordinator
    ///    - animated: Pass true to animate the presentation; otherwise, pass false.
    ///    - completion: completion run after add children view controller
    public func presentChild(_ viewController: UIViewController, animated: Bool = true, completion: (()->Swift.Void)? = nil) {
        rootViewController.present(viewController, animated: animated, completion: completion)
    }

    /// Dismiss view controller in rootViewController
    ///
    /// - Parameters:
    ///    - controller: View controller will removed in rootViewController of coordinator with dismiss method
    ///    - completion: completion run after remove children view controller
    public func dismissChild(_ controller: UIViewController, animated: Bool = true, completion: (() -> Swift.Void)? = nil) {
        controller.dismiss(animated: animated, completion: completion)
    }
}

/// Extension for UINavigationController
extension RootViewCoordinatorProvider {
    
    /// Push view controller in stack of navigation rootViewController,
    /// Only when rootViewController is `UINavigationController`
    ///
    /// - Parameters:
    ///    - controller: View controller will add in rootViewController of coordinator
    ///    - animated: Pass true to animate the presentation; otherwise, pass false.
    ///    - completion: completion run after add children view controller
    public func pushChild(_ controller: UIViewController, animated: Bool = true, completion: (()->Swift.Void)? = nil) {
        guard let navigation = rootViewController as? UINavigationController else { return }
        navigation.pushViewController(controller, animated: animated)
        // Run Closure
        completion?()
    }

    /// Add view controller in stack controllers of navigation rootViewController,
    /// Only when rootViewController is `UINavigationController`
    ///
    /// - Parameters:
    ///    - controller: View controller will add in stack of rootViewController of coordinator
    ///    - completion: completion run after add children view controller
    public func addChildInNavigation(_ controller: UIViewController, completion: (()->Swift.Void)? = nil) {
        guard let navigation = rootViewController as? UINavigationController else { return }
        navigation.viewControllers.append(controller)
        // Run Closure
        completion?()
    }
    
    /// Insert view controller in stack controllers of navigation rootViewController,
    /// Only when rootViewController is `UINavigationController`
    ///
    /// - Parameters:
    ///    - controller: View controller will add in stack of rootViewController of coordinator.
    ///    - at: Int Position of when would you put the new ViewController
    ///    - completion: completion run after add children view controller.
    public func insertChildInNavigation(_ controller: UIViewController, at index: Int , completion: (()->Swift.Void)? = nil) {
        guard let navigation = rootViewController as? UINavigationController else { return }
        navigation.viewControllers.insert(controller, at: index)
        completion?()
    }
    
     /// Extract view controller in stack controllers of navigation rootViewController, Only when rootViewController is `UINavigationController`
     ///
     /// - Parameters:
     ///   - at: Int Position of when would you put the new ViewController
     ///   - completion: completion run after add children view controller.
    @discardableResult
    public func extractChildInNavigation(at index: Int, completion:(() -> Swift.Void)? = nil) -> UIViewController? {
        guard let navigation = rootViewController as? UINavigationController else { return nil }
        let viewController = navigation.viewControllers.remove(at: index)
        completion?()
        return viewController
    }
    
    /// Remove view controller in stack of viewcontrollers of UINavigationController in rootViewController
    /// Only when rootViewController is `UINavigationController`
    ///
    /// - Parameters:
    ///    - controller: View controller will removed in rootViewController of coordinator with dismiss method
    ///    - completion: completion run after remove children view controller
    @discardableResult
    public func popInNavigation(_ controller: UIViewController, completion: (()->Swift.Void)? = nil) -> UIViewController? {
        guard let navigation = rootViewController as? UINavigationController else { return nil }
        let viewController = navigation.remove(controller: controller)
        // Run Closure
        completion?()
        return viewController
    }
    
     /// Remove all viewControllers from UINavigationController in rootViewController
     /// Only when rootViewController is `UINavigationController`
     ///
     /// - Parameters:
     ///   - completion: completion run after remove children view controller
    public func popRemoveAllInNavigation(_ completion: (()->Swift.Void)? = nil) {
        guard let navigation = rootViewController as? UINavigationController else { return }
        navigation.viewControllers.removeAll()
        // Run Closure
        completion?()
    }
    
    
    /// Pop to root from UINavigationController in rootViewController
    /// Only when rootViewController is `UINavigationController`
    ///
    /// - Parameters:
    ///    - completion: completion run after remove children view controller
    @discardableResult
    public func popToRootInNavigation(_ completion: (()->Swift.Void)? = nil) -> [UIViewController]? {
        guard let navigation = rootViewController as? UINavigationController else { return nil }
        var count = navigation.viewControllers.count
        var removedViewController: [UIViewController] = []
        while count > 1 {
            removedViewController.append(navigation.viewControllers.removeLast())
            count -= 1
        }
        // Run Closure
        completion?()
        return removedViewController
    }
    
    ///  Pop to last from UINavigationController in rootViewController
    ///  Only when rootViewController is `UINavigationController`
    ///
    ///  - Parameters:
    ///  - completion: completion run after remove children view controller
    @discardableResult
    public func popInNavigation(_ completion: (()->Swift.Void)? = nil) -> UIViewController? {
        guard let navigation = rootViewController as? UINavigationController else { return nil }
        let lastController = navigation.viewControllers.removeLast()
        // Run Closure
        completion?()
        return lastController
    }
}

/// Extension for UITabBarController
extension RootViewCoordinatorProvider {

    ///  Add view controller in stack controllers of tabbar rootViewController,
    ///  Only when rootViewController is `UITabBarController`
    ///
    ///  - Parameters:
    ///     - controller: View controller will add in stack of rootViewController of coordinator
    ///     - completion: completion run after add children view controller
    public func addChildInTabBar(_ viewController: UIViewController, completion: (()->Swift.Void)? = nil) {
        guard let tabBar = rootViewController as? UITabBarController else { return }
        if tabBar.viewControllers == nil {
            tabBar.viewControllers = []
        }
        tabBar.viewControllers?.append(viewController)
        // Run Closure
        completion?()
    }
    
    ///  Remove view controller from tabbar in rootViewController
    ///  Only when rootViewController is `UITabBarController`
    ///
    ///  - Parameters:
    ///     - controller: View controller will removed in rootViewController of coordinator with dismiss method
    ///     - completion: completion run after remove children view controller
    public func removeChildInTabBar(_ viewController: UIViewController, completion: (()->Swift.Void)? = nil) {
        guard let tabBar = rootViewController as? UITabBarController else { return }
        tabBar.viewControllers = tabBar.viewControllers?.filter { $0 != viewController }
        // Run Closure
        completion?()
    }
}

/// Extension for UISplitViewController
extension RootViewCoordinatorProvider {

    ///  Add view controller in stack controllers of splitview rootViewController,
    ///  Only when rootViewController is `UISplitViewController`
    ///
    ///  - Parameters:
    ///     - controller: View controller will add in stack of rootViewController of coordinator
    ///     - completion: completion run after add children view controller
    public func addChildInSplitView(_ controller: UIViewController, completion: (()->Swift.Void)? = nil) {
        guard let splitView = rootViewController as? UISplitViewController else { return }
        splitView.viewControllers.append(controller)
        // Run Closure
        completion?()
    }

    ///  Add view controller in master of splitview rootViewController,
    ///  Only when rootViewController is `UISplitViewController`
    ///
    ///  - Parameters:
    ///    - controller: View controller will add in stack of rootViewController of coordinator
    ///     - completion: completion run after add children view controller
    public func showChildInSplitViewDetail(_ controller: UIViewController, completion: (()->Swift.Void)? = nil) {
        guard let splitView = rootViewController as? UISplitViewController else { return }
        splitView.showDetailViewController(controller, sender: self)
        // Run Closure
        completion?()
    }

    ///  Remove view controller from splitView in rootViewController
    ///  Only when rootViewController is `UISplitViewController`
    ///
    ///  - Parameters:
    ///    - controller: View controller will removed in rootViewController of coordinator with dismiss method
    ///     - completion: completion run after remove children view controller
    public func removeChildInSplitView(_ controller: UIViewController, completion: (()->Swift.Void)? = nil) {
        guard let splitView = rootViewController as? UISplitViewController else { return }
        splitView.viewControllers = splitView.viewControllers.filter { $0 != controller }
        // Run Closure
        completion?()
    }
}

/// Enxtension for UIPageViewController
extension RootViewCoordinatorProvider {
    
    ///  Add view controller in stack controllers of page rootViewController,
    ///  Only when rootViewController is `UIPageViewController`
     
    ///  - Parameters:
    ///     - controller: View controller will add in stack of rootViewController of coordinator
    ///     - completion: completion run after add children view controller
    public func addChildInPageController(_ controller: UIViewController, completion: (() -> Swift.Void)? = nil) {
        guard let pageViewController = rootViewController as? UIPageViewController else { return }
        pageViewController.addChild(controller)
        completion?()
    }
}

/// Extension for add coordinator in an other coordinator
extension RootViewCoordinatorProvider {
    
    /// Attach view of viewController in rootViewController,
    ///
    ///  - Parameters:
    ///     - viewController: View controller will add in rootViewController of coordinator
    ///     - bounds: Size of view in view of rootViewController coodrinator
    ///     - completion: completion run after add children view controller
    public func attachChild(_ controller: UIViewController, bounds: CGRect? = nil, completion: (() -> Swift.Void)? = nil) {
        // Configure Child View
        controller.view.frame = bounds ?? rootViewController.view.bounds
        
        // Add a view in parent view
        rootViewController.view.addSubview(controller.view)
        rootViewController.view.bringSubviewToFront(controller.view)
        
        // Run closure
        completion?()
    }

    /// Dettach view of viewController in rootViewController,
    ///
    ///  - Parameters:
    ///     - viewController: View controller will add in rootViewController of coordinator
    ///     - completion: completion run after add children view controller
    public func detachChild(_ controller: UIViewController, completion: (() -> Swift.Void)? = nil) {
        // remove a view in parent view
        controller.view.removeFromSuperview()
        
        // Run closure
        completion?()
    }
}

/// Extension for add coordinator in an other coordinator
extension RootViewCoordinator {
    
    ///  Attach view of viewController of childrenCoordinator in rootViewController of parentCoordinator,
    ///
    ///  - Parameters:
    ///     - coordinator: childrenCoordinator we will add rootViewController in rootViewController of parent coordinator
    ///     - bounds: Size of view in view of rootViewController coodrinator
    ///     - completion: completion run after add children view controller
    public func addChildCoordinator(_ coordinator: RootViewCoordinator, bounds: CGRect? = nil, completion: (() -> Swift.Void)? = nil) {
        add(coordinator: coordinator)
        coordinator.parentRootViewCoordinator = self
        addChild(coordinator.rootViewController, bounds: bounds, completion: completion)
    }

    /// Remove rootViewController of coordinator in parent rootViewController coordinator,
    ///
    ///  - Parameters:
    ///     - coordinator: childrenCoordinator we will remove rootViewController in rootViewController parent coordinator
    ///     - completion: completion run after add children view controller
    public func removeChildCoordinator(_ coordinator: RootViewCoordinator, completion: (() -> Swift.Void)? = nil) {
        removeChild(coordinator.rootViewController, completion: completion)
        coordinator.parentRootViewCoordinator = nil
        remove(coordinator: coordinator)
    }
}

/// Extension for add coordinator in an other coordinator
extension RootViewCoordinator {

     /// Present view of viewController of childrenCoordinator in rootViewController of parentCoordinator,
    ///
    ///  - Parameters:
    ///     - children: coordinator we will add rootViewController in parent rootViewController coordinator
    ///    - animated: Pass true to animate the presentation; otherwise, pass false.
    ///     - completion: completion run after add children view controller
    public func presentChildCoordinator(_ coordinator: RootViewCoordinator, animated: Bool = true, completion: (()->Swift.Void)? = nil) {
        coordinator.parentRootViewCoordinator = self
        add(coordinator: coordinator)
        presentChild(coordinator.rootViewController, animated: animated, completion: completion)
    }

    ///  Dismiss view of viewController of childrenCoordinator in rootViewController of parentCoordinator,
    ///
    ///  - Parameters:
    ///     - children: coordinator we will dismiss rootViewController in parent rootViewController coordinator
    ///     - animated: Pass true to animate the presentation; otherwise, pass false.
    ///     - completion: completion run after add children view controller
    public func dismissChildCoordinator(_ coordinator: RootViewCoordinator, animated: Bool = true, completion: (()->Swift.Void)? = nil) {
        dismissChild(coordinator.rootViewController, animated: animated, completion: completion)
        remove(coordinator: coordinator)
        coordinator.parentRootViewCoordinator = nil
    }
}

/// Extension for add coordinator in an other coordinator
extension RootViewCoordinator {
    
     /// Push viewController of childrenCoordinator in rootViewController of parentCoordinator,
     ///
     /// - Parameters:
     ///    - children: coordinator we will dismiss rootViewController in parent rootViewController coordinator
     ///    - animated: Pass true to animate the presentation; otherwise, pass false.
     ///    - completion: completion run after add children view controller
    public func pushChildCoordinator(_ coordinator: RootViewCoordinator, animated: Bool = true, completion: (()->Swift.Void)? = nil) {
        coordinator.parentRootViewCoordinator = self
        add(coordinator: coordinator)
        pushChild(coordinator.rootViewController, animated: animated, completion: completion)
    }
    
     /// Insert viewController of childrenCoordinator in rootViewController of parentCoordinator,
     ///
     ///    - Parameters:
     ///    - children: coordinator we will dismiss rootViewController in parent rootViewController coordinator
     ///    - animated: Pass true to animate the presentation; otherwise, pass false.
     ///    - completion: completion run after add children view controller
    public func insertChildCoordinator(_ coordinator: RootViewCoordinator, at index: Int, completion: (()->Swift.Void)? = nil) {
        coordinator.parentRootViewCoordinator = self
        add(coordinator: coordinator)
        insertChildInNavigation(coordinator.rootViewController, at: index, completion: completion)
    }
    
    /// Pop coordinator rootViewController of parentCoordinator,
    ///
    /// - Parameters:
    /// - coordinator: coordinator we will remove in parent navigation rootViewController coordinator
    /// - completion: completion run after add children view controller
    public func popChildCoordinator(_ coordinator: RootViewCoordinator, completion: (()->Swift.Void)? = nil) {
        popInNavigation(coordinator.rootViewController, completion: completion)
        remove(coordinator: coordinator)
        coordinator.parentRootViewCoordinator = nil
    }
}

extension RootViewCoordinator {
    internal func remove(viewController: UIViewController, isChild: Bool = false) {
        if viewController is UINavigationController {
            (self.rootViewController as? UINavigationController)?.remove(controller: viewController)
            
        } else if viewController is UITabBarController {
            (self.rootViewController as? UITabBarController)?.remove(controller: viewController)
        } else if viewController is UISplitViewController {
            if isChild {
                (self.rootViewController as? UISplitViewController)?.remove(childController: viewController)
            } else {
                (self.rootViewController as? UISplitViewController)?.remove(controller: viewController)
            }
        }
    }
}
#endif

#endif
