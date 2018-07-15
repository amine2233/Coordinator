#if canImport(UIKit)
import UIKit

#if !os(watchOS)
public extension RootViewCoordinatorProvider {
    /**
     Add children view controller in rootViewController coordinator

     - Parameter children: View controller will add in rootViewController of coordinator
     - Parameter bounds: Size of view in view of rootViewController coodrinator
     - Parameter completion: completion run after add children view controller
     */
    public func add(controller children: UIViewController, bounds: CGRect? = nil, completion: (() -> Swift.Void)? = nil) {
        // Add Child View Controller
        rootViewController.addChildViewController(children)
        
        // Configure Child View
        children.view.frame = bounds ?? rootViewController.view.bounds
        children.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        // Add Child View as Subview
        rootViewController.view.addSubview(children.view)
        
        // Notify Child View Controller
        children.didMove(toParentViewController: rootViewController)
        
        // Run closure
        completion?()
    }

    /**
     Remove children view controller in rootViewController

     - Parameter children: View controller will removed in rootViewController of coordinator
     - Parameter completion: completion run after remove children view controller
     */
    public func remove(controller children: UIViewController, completion: (() -> Swift.Void)? = nil) {
        // Notify Child View Controller
        children.willMove(toParentViewController: nil)
        
        // Remove Child View From Superview
        children.view.removeFromSuperview()
        
        // Notify Child View Controller
        children.removeFromParentViewController()
        
        // Run Closure
        completion?()
    }

    /**
     Present view controller in rootViewController of coordinator

     - Parameter viewController: View controller will add in rootViewController of coordinator
     - Parameter animated: Pass true to animate the presentation; otherwise, pass false.
     - Parameter completion: completion run after add children view controller
     */
    public func present(to viewController: UIViewController, animated: Bool = true, completion: (()->Swift.Void)? = nil) {
        rootViewController.present(viewController, animated: animated, completion: completion)
    }

    /**
     Dismiss view controller in rootViewController

     - Parameter to: View controller will removed in rootViewController of coordinator with dismiss method
     - Parameter completion: completion run after remove children view controller
     */
    public func dismiss(controller viewController: UIViewController, animated: Bool = true, completion: (() -> Swift.Void)? = nil) {
        viewController.dismiss(animated: animated, completion: completion)
    }

    /**
     Push view controller in stack of navigation rootViewController,
     Only when rootViewController is `UINavigationController`

     - Parameter viewController: View controller will add in rootViewController of coordinator
     - Parameter animated: Pass true to animate the presentation; otherwise, pass false.
     - Parameter completion: completion run after add children view controller
     */
    public func push(to viewController: UIViewController, animated: Bool = true, completion: (()->Swift.Void)? = nil) {
        guard let navigation = rootViewController as? UINavigationController else { return }
        navigation.pushViewController(viewController, animated: animated)
        // Run Closure
        completion?()
    }

    /**
     Add view controller in stack controllers of navigation rootViewController,
     Only when rootViewController is `UINavigationController`

     - Parameter viewController: View controller will add in stack of rootViewController of coordinator
     - Parameter completion: completion run after add children view controller
     */
    public func add(inNavigation viewController: UIViewController, animated: Bool = true, completion: (()->Swift.Void)? = nil) {
        guard let navigation = rootViewController as? UINavigationController else { return }
        navigation.viewControllers.append(viewController)
        // Run Closure
        completion?()
    }

    /**
     Add view controller in stack controllers of tabbar rootViewController,
     Only when rootViewController is `UITabBarController`

     - Parameter viewController: View controller will add in stack of rootViewController of coordinator
     - Parameter completion: completion run after add children view controller
     */
    public func add(inTabBar viewController: UIViewController, completion: (()->Swift.Void)? = nil) {
        guard let tabBar = rootViewController as? UITabBarController else { return }
        if tabBar.viewControllers == nil {
            tabBar.viewControllers = []
        }
        tabBar.viewControllers?.append(viewController)
        // Run Closure
        completion?()
    }

    /**
     Add view controller in stack controllers of splitview rootViewController,
     Only when rootViewController is `UISplitViewController`

     - Parameter viewController: View controller will add in stack of rootViewController of coordinator
     - Parameter completion: completion run after add children view controller
     */
    public func add(inSplitView viewController: UIViewController, completion: (()->Swift.Void)? = nil) {
        guard let splitView = rootViewController as? UISplitViewController else { return }
        splitView.viewControllers.append(viewController)
        // Run Closure
        completion?()
    }

    /**
     Add view controller in master of splitview rootViewController,
     Only when rootViewController is `UISplitViewController`

     - Parameter viewController: View controller will add in stack of rootViewController of coordinator
     - Parameter completion: completion run after add children view controller
     */
    public func show(inDetailSplitView viewController: UIViewController, completion: (()->Swift.Void)? = nil) {
        guard let splitView = rootViewController as? UISplitViewController else { return }
        splitView.showDetailViewController(viewController, sender: self)
        // Run Closure
        completion?()
    }

    /**
     Remove view controller from tabbar in rootViewController
     Only when rootViewController is `UITabBarController`

     - Parameter to: View controller will removed in rootViewController of coordinator with dismiss method
     - Parameter completion: completion run after remove children view controller
     */
    public func remove(fromTabBar viewController: UIViewController, completion: (()->Swift.Void)? = nil) {
        guard let tabBar = rootViewController as? UITabBarController else { return }
        tabBar.viewControllers = tabBar.viewControllers?.filter { $0 != viewController }
        // Run Closure
        completion?()
    }

    /**
     Remove view controller from splitView in rootViewController
     Only when rootViewController is `UISplitViewController`

     - Parameter to: View controller will removed in rootViewController of coordinator with dismiss method
     - Parameter completion: completion run after remove children view controller
     */
    public func remove(fromSplitView viewController: UIViewController, completion: (()->Swift.Void)? = nil) {
        guard let splitView = rootViewController as? UISplitViewController else { return }
        splitView.viewControllers = splitView.viewControllers.filter { $0 != viewController }
        // Run Closure
        completion?()
    }

    /**
     Remove view controller in stack of viewcontrollers of UINavigationController in rootViewController
     Only when rootViewController is `UINavigationController`

     - Parameter from: View controller will removed in rootViewController of coordinator with dismiss method
     - Parameter completion: completion run after remove children view controller
     */
    public func pop(from viewController: UIViewController, completion: (()->Swift.Void)? = nil) {
        guard let navigation = rootViewController as? UINavigationController else { return }
        navigation.remove(controller: viewController)
        // Run Closure
        completion?()
    }

    /**
     Remove all viewControllers from UINavigationController in rootViewController
     Only when rootViewController is `UINavigationController`

     - Parameter completion: completion run after remove children view controller
     */
    public func popRemoveAll(completion: (()->Swift.Void)? = nil) {
        guard let navigation = rootViewController as? UINavigationController else { return }
        navigation.viewControllers.removeAll()
        // Run Closure
        completion?()
    }
    
    /**
     Pop to root from UINavigationController in rootViewController
     Only when rootViewController is `UINavigationController`
     
     - Parameter completion: completion run after remove children view controller
     */
    public func popToRoot(completion: (()->Swift.Void)? = nil) {
        guard let navigation = rootViewController as? UINavigationController else { return }
        navigation.viewControllers.remove(at: 0)
        // Run Closure
        completion?()
    }
}

public extension RootViewCoordinatorProvider {
    /**
     Attach view of viewController in rootViewController,

     - Parameter viewController: View controller will add in rootViewController of coordinator
     - Parameter bounds: Size of view in view of rootViewController coodrinator
     - Parameter completion: completion run after add children view controller
     */
    public func attach(children: UIViewController, bounds: CGRect? = nil, completion: (() -> Swift.Void)? = nil) {
        // Configure Child View
        children.view.frame = bounds ?? rootViewController.view.bounds
        
        // Add a view in parent view
        rootViewController.view.addSubview(children.view)
        rootViewController.view.bringSubview(toFront: children.view)
        
        // Run closure
        completion?()
    }

    /**
     Dettach view of viewController in rootViewController,

     - Parameter viewController: View controller will add in rootViewController of coordinator
     - Parameter completion: completion run after add children view controller
     */
    public func detach(children: UIViewController, completion: (() -> Swift.Void)? = nil) {
        // remove a view in parent view
        children.view.removeFromSuperview()
        
        // Run closure
        completion?()
    }
}

public extension RootViewCoordinator {
    /**
     Attach view of viewController of childrenCoordinator in rootViewController of parentCoordinator,

     - Parameter childrenCoordinator: childrenCoordinator we will add rootViewController in rootViewController of parent coordinator
     - Parameter bounds: Size of view in view of rootViewController coodrinator
     - Parameter completion: completion run after add children view controller
     */
    public func add(to coordinator: RootViewCoordinator, bounds: CGRect? = nil, completion: (() -> Swift.Void)? = nil) {
        coordinator.parentRootViewCoordinatorProvider = self
        add(coordinator: coordinator)
        add(controller: coordinator.rootViewController, bounds: bounds, completion: completion)
    }

    /**
     Remove rootViewController of coordinator in parent rootViewController coordinator,

     - Parameter childrenCoordinator: childrenCoordinator we will remove rootViewController in rootViewController parent coordinator
     - Parameter completion: completion run after add children view controller
     */
    public func remove(from coordinator: RootViewCoordinator, completion: (() -> Swift.Void)? = nil) {
        coordinator.parentRootViewCoordinatorProvider = nil
        remove(controller: coordinator.rootViewController, completion: completion)
        remove(coordinator: coordinator)
    }

    /**
     Present view of viewController of childrenCoordinator in rootViewController of parentCoordinator,

     - Parameter childrenCoordinator: coordinator we will add rootViewController in parent rootViewController coordinator
     - Parameter animated: Pass true to animate the presentation; otherwise, pass false.
     - Parameter completion: completion run after add children view controller
     */
    public func present(to coordinator: RootViewCoordinator, animated: Bool = true, completion: (()->Swift.Void)? = nil) {
        coordinator.parentRootViewCoordinatorProvider = self
        add(coordinator: coordinator)
        present(to: coordinator.rootViewController, animated: animated, completion: completion)
    }

    /**
     Dismiss view of viewController of childrenCoordinator in rootViewController of parentCoordinator,

     - Parameter childrenCoordinator: coordinator we will dismiss rootViewController in parent rootViewController coordinator
     - Parameter animated: Pass true to animate the presentation; otherwise, pass false.
     - Parameter completion: completion run after add children view controller
     */
    public func dismiss(from coordinator: RootViewCoordinator, animated: Bool = true, completion: (()->Swift.Void)? = nil) {
        coordinator.parentRootViewCoordinatorProvider = nil
        coordinator.rootViewController.dismiss(animated: animated, completion: completion)
        remove(coordinator: coordinator)
    }
    
    /**
     Push viewController of childrenCoordinator in rootViewController of parentCoordinator,
     
     - Parameter childrenCoordinator: coordinator we will dismiss rootViewController in parent rootViewController coordinator
     - Parameter animated: Pass true to animate the presentation; otherwise, pass false.
     - Parameter completion: completion run after add children view controller
     */
    public func push(to coordinator: RootViewCoordinator, animated: Bool = true, completion: (()->Swift.Void)? = nil) {
        coordinator.parentRootViewCoordinatorProvider = self
        add(coordinator: coordinator)
        push(to: coordinator.rootViewController, animated: animated, completion: completion)
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
