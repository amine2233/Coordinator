#if canImport(UIKit)
import UIKit

#if !os(watchOS)
public protocol RootViewCoordinatorProvider: class {
    var parentRootViewCoordinatorProvider: RootViewCoordinatorProvider? { get set }
    var rootViewController: UIViewController { get }
}

public protocol RootViewCoordinator: Coordinator, RootViewCoordinatorProvider {}

public extension RootViewCoordinatorProvider {
    /**
     Add children view controller in rootViewController coordinator

     - Parameter children: View controller will add in rootViewController of coordinator
     - Parameter bounds: Size of view in view of rootViewController coodrinator
     - Parameter completion: completion run after add children view controller
     */
    public func addChildren(_ children: UIViewController, bounds: CGRect? = nil, completion: (() -> Swift.Void)? = nil) {
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
    public func removeChildren(_ children: UIViewController, completion: (() -> Swift.Void)? = nil) {
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
    public func presentRootViewController(to viewController: UIViewController, animated: Bool = true, completion: (() -> Swift.Void)? = nil) {
        rootViewController.present(viewController, animated: animated, completion: completion)
    }

    /**
     Dismiss view controller in rootViewController

     - Parameter to: View controller will removed in rootViewController of coordinator with dismiss method
     - Parameter completion: completion run after remove children view controller
     */
    public func dismissRootViewController(to viewController: UIViewController, animated: Bool = true, completion: (() -> Swift.Void)? = nil) {
        viewController.dismiss(animated: animated, completion: completion)
    }

    /**
     Push view controller in stack of navigation rootViewController,
     Only when rootViewController is `UINavigationController`

     - Parameter viewController: View controller will add in rootViewController of coordinator
     - Parameter animated: Pass true to animate the presentation; otherwise, pass false.
     - Parameter completion: completion run after add children view controller
     */
    public func pushRootViewController(to viewController: UIViewController, animated: Bool = true, completion: (() -> Swift.Void)? = nil) {
        (rootViewController as? UINavigationController)?.pushViewController(viewController, animated: animated)
        // Run Closure
        completion?()
    }

    /**
     Add view controller in stack controllers of navigation rootViewController,
     Only when rootViewController is `UINavigationController`

     - Parameter viewController: View controller will add in stack of rootViewController of coordinator
     - Parameter completion: completion run after add children view controller
     */
    public func addInNavigation(_ viewController: UIViewController, completion: (() -> Swift.Void)? = nil) {
        (rootViewController as? UINavigationController)?.viewControllers.append(viewController)
        // Run Closure
        completion?()
    }

    /**
     Add view controller in stack controllers of tabbar rootViewController,
     Only when rootViewController is `UITabBarController`

     - Parameter viewController: View controller will add in stack of rootViewController of coordinator
     - Parameter completion: completion run after add children view controller
     */
    public func addInTabBar(_ viewController: UIViewController, completion: (() -> Swift.Void)? = nil) {
        if (rootViewController as? UITabBarController)?.viewControllers == nil {
            (rootViewController as? UITabBarController)?.viewControllers = []
        }
        (rootViewController as? UITabBarController)?.viewControllers?.append(viewController)
        // Run Closure
        completion?()
    }

    /**
     Add view controller in stack controllers of splitview rootViewController,
     Only when rootViewController is `UISplitViewController`

     - Parameter viewController: View controller will add in stack of rootViewController of coordinator
     - Parameter completion: completion run after add children view controller
     */
    public func addInSplitView(_ viewController: UIViewController, completion: (() -> Swift.Void)? = nil) {
        (rootViewController as? UISplitViewController)?.viewControllers.append(viewController)
        // Run Closure
        completion?()
    }

    /**
     Add view controller in master of splitview rootViewController,
     Only when rootViewController is `UISplitViewController`

     - Parameter viewController: View controller will add in stack of rootViewController of coordinator
     - Parameter completion: completion run after add children view controller
     */
    public func showInSplitView(_ viewController: UIViewController, completion: (() -> Swift.Void)? = nil) {
        (rootViewController as? UISplitViewController)?.show(viewController, sender: self)
        // Run Closure
        completion?()
    }

    /**
     Add view controller in detail of splitview rootViewController,
     Only when rootViewController is `UISplitViewController`

     - Parameter viewController: View controller will add in stack of rootViewController of coordinator
     - Parameter completion: completion run after add children view controller
     */
    public func showInDetailSplitView(_ viewController: UIViewController, completion: (() -> Swift.Void)? = nil) {
        (rootViewController as? UISplitViewController)?.showDetailViewController(viewController, sender: self)
        // Run Closure
        completion?()
    }

    /**
     Remove view controller from tabbar in rootViewController
     Only when rootViewController is `UITabBarController`

     - Parameter to: View controller will removed in rootViewController of coordinator with dismiss method
     - Parameter completion: completion run after remove children view controller
     */
    public func removeFromTabBar(_ viewController: UIViewController, completion: (() -> Swift.Void)? = nil) {
        (rootViewController as? UITabBarController)?.removeViewController(viewController)
        // Run Closure
        completion?()
    }

    /**
     Remove view controller from splitView in rootViewController
     Only when rootViewController is `UISplitViewController`

     - Parameter to: View controller will removed in rootViewController of coordinator with dismiss method
     - Parameter completion: completion run after remove children view controller
     */
    public func removeFromSplitView(_ viewController: UIViewController, completion: (() -> Swift.Void)? = nil) {
        (rootViewController as? UISplitViewController)?.removeViewController(viewController)
        // Run Closure
        completion?()
    }

    /**
     Remove view controller in stack of viewcontrollers of UINavigationController in rootViewController
     Only when rootViewController is `UINavigationController`

     - Parameter from: View controller will removed in rootViewController of coordinator with dismiss method
     - Parameter completion: completion run after remove children view controller
     */
    public func popRemoveLast(from viewController: UIViewController, completion: (() -> Swift.Void)? = nil) {
        (rootViewController as? UINavigationController)?.removeViewController(viewController)
        // Run Closure
        completion?()
    }

    /**
     Remove all viewControllers from UINavigationController in rootViewController
     Only when rootViewController is `UINavigationController`

     - Parameter completion: completion run after remove children view controller
     */
    public func popRemoveAll(completion: (() -> Swift.Void)? = nil) {
        (rootViewController as? UINavigationController)?.viewControllers.removeAll()
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
    public func attachChildrenView(_ viewController: UIViewController, bounds: CGRect? = nil, completion: (() -> Swift.Void)? = nil) {
        // Configure Child View
        viewController.view.frame = bounds ?? rootViewController.view.bounds

        // Add a view in parent view
        rootViewController.view.addSubview(viewController.view)
        rootViewController.view.bringSubview(toFront: viewController.view)

        // Run closure
        completion?()
    }

    /**
     Dettach view of viewController in rootViewController,

     - Parameter viewController: View controller will add in rootViewController of coordinator
     - Parameter completion: completion run after add children view controller
     */
    public func detachChildrenView(_ viewController: UIViewController, completion: (() -> Swift.Void)? = nil) {
        // remove a view in parent view
        viewController.view.removeFromSuperview()

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
    public func addChildrenCoordinator(_ childrenCoordinator: RootViewCoordinator, bounds: CGRect? = nil, completion: (() -> Swift.Void)? = nil) {
        childrenCoordinator.parentRootViewCoordinatorProvider = self
        add(childrenCoordinator)
        addChildren(childrenCoordinator.rootViewController, bounds: bounds, completion: completion)
    }

    /**
     Remove rootViewController of coordinator in parent rootViewController coordinator,

     - Parameter childrenCoordinator: childrenCoordinator we will remove rootViewController in rootViewController parent coordinator
     - Parameter completion: completion run after add children view controller
     */
    public func removeChildrenCoordinator(_ childrenCoordinator: RootViewCoordinator, completion: (() -> Swift.Void)? = nil) {
        childrenCoordinator.parentRootViewCoordinatorProvider = nil
        remove(childrenCoordinator)
        removeChildren(childrenCoordinator.rootViewController, completion: completion)
    }

    /**
     Present view of viewController of childrenCoordinator in rootViewController of parentCoordinator,

     - Parameter childrenCoordinator: coordinator we will add rootViewController in parent rootViewController coordinator
     - Parameter animated: Pass true to animate the presentation; otherwise, pass false.
     - Parameter completion: completion run after add children view controller
     */
    public func presentRootViewControllerCoordinator(_ childrenCoordinator: RootViewCoordinator, animated: Bool = true, completion: (() -> Swift.Void)? = nil) {
        childrenCoordinator.parentRootViewCoordinatorProvider = self
        add(childrenCoordinator)
        presentRootViewController(to: childrenCoordinator.rootViewController, animated: animated, completion: completion)
    }

    /**
     Dismiss view of viewController of childrenCoordinator in rootViewController of parentCoordinator,

     - Parameter childrenCoordinator: coordinator we will dismiss rootViewController in parent rootViewController coordinator
     - Parameter animated: Pass true to animate the presentation; otherwise, pass false.
     - Parameter completion: completion run after add children view controller
     */
    public func dismissRootViewControllerCoordinator(_ childrenCoordinator: RootViewCoordinator, animated: Bool = true, completion: (() -> Swift.Void)? = nil) {
        childrenCoordinator.parentRootViewCoordinatorProvider = nil
        remove(childrenCoordinator)
        childrenCoordinator.rootViewController.dismiss(animated: animated, completion: completion)
    }
}
#endif

#endif
