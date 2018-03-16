//
//  RootViewCoordinatorProvider.swift
//  Coordinator
//
//  Created by Amine Bensalah on 06/03/2018.
//

import UIKit

public protocol RootViewCoordinatorProvider: class {
    var parentRootViewCoordinatorProvider: RootViewCoordinatorProvider? { get set }
    var rootViewController: UIViewController { get }
}

public protocol RootViewCoordinator: Coordinator, RootViewCoordinatorProvider { }

public extension RootViewCoordinatorProvider {
    
    /// Add view controller in rootViewController
    public func add(children: UIViewController, bounds: CGRect? = nil, completion: (() -> Swift.Void)? = nil) {
        // Add Child View Controller
        self.rootViewController.addChildViewController(children)
        
        // Configure Child View
        children.view.frame = bounds ?? self.rootViewController.view.bounds
        children.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        // Add Child View as Subview
        self.rootViewController.view.addSubview(children.view)
        
        // Notify Child View Controller
        children.didMove(toParentViewController: self.rootViewController)
        
        // Run closure
        completion?()
    }
    
    /// Remove view controller
    public func remove(children: UIViewController, completion: (() -> Swift.Void)? = nil) {
        // Notify Child View Controller
        children.willMove(toParentViewController: nil)
        
        // Remove Child View From Superview
        children.view.removeFromSuperview()
        
        // Notify Child View Controller
        children.removeFromParentViewController()
        
        // Run Closure
        completion?()
    }
    
    /// Present view controller in rootViewController
    public func present(to viewController: UIViewController, animated: Bool = true, completion: (()->Swift.Void)? = nil) {
        self.rootViewController.present(viewController, animated: animated, completion: completion)
    }
    
    /// Push view controller in rootViewController
    public func push(to viewController: UIViewController, animated: Bool = true, completion: (()->Swift.Void)? = nil) {
        (self.rootViewController as? UINavigationController)?.pushViewController(viewController, animated: animated)
        // Run Closure
        completion?()
    }
    
    /// Push view controller in rootViewController
    public func add(inNavigation viewController: UIViewController, animated: Bool = true, completion: (()->Swift.Void)? = nil) {
        (self.rootViewController as? UINavigationController)?.viewControllers.append(viewController)
        // Run Closure
        completion?()
    }
    
    /// Append view controller in tabbar rootViewController
    public func add(inTabBar viewController: UIViewController, completion: (()->Swift.Void)? = nil) {
        if (self.rootViewController as? UITabBarController)?.viewControllers == nil {
            (self.rootViewController as? UITabBarController)?.viewControllers = []
        }
        (self.rootViewController as? UITabBarController)?.viewControllers?.append(viewController)
        // Run Closure
        completion?()
    }
    
    /// Append view controller in master splitview rootViewController
    public func add(inSplitView viewController: UIViewController, completion: (()->Swift.Void)? = nil) {
        (self.rootViewController as? UISplitViewController)?.viewControllers.append(viewController)
        // Run Closure
        completion?()
    }
    
    /// Append view controller in detail splitview rootViewController
    public func add(inDetailSplitView viewController: UIViewController, completion: (()->Swift.Void)? = nil) {
        (self.rootViewController as? UISplitViewController)?.showDetailViewController(viewController, sender: self)
        // Run Closure
        completion?()
    }
    
    /// Remove view controller in tabbar rootViewController
    public func remove(fromTabBar viewController: UIViewController, completion: (()->Swift.Void)? = nil) {
        (self.rootViewController as? UITabBarController)?.remove(viewController: viewController)
        // Run Closure
        completion?()
    }
    
    /// Remove view controller in master splitview rootViewController
    public func remove(fromSplitView viewController: UIViewController, completion: (()->Swift.Void)? = nil) {
        (self.rootViewController as? UISplitViewController)?.remove(viewController: viewController)
        // Run Closure
        completion?()
    }
    
    /// Remove view controller in detail splitview rootViewController
    public func remove(fromDetailSplitView viewController: UIViewController, completion: (()->Swift.Void)? = nil) {
        (self.rootViewController as? UISplitViewController)?.remove(childController: viewController)
        // Run Closure
        completion?()
    }
    
    /// Pop view controller in an other view controller or only pop view controller
    public func pop(from viewController: UIViewController, completion: (()->Swift.Void)? = nil) {
        (self.rootViewController as? UINavigationController)?.remove(viewController: viewController)
        // Run Closure
        completion?()
    }
    
    /// Pop & remove all childs view controller in an other view controller or only pop view controller
    public func popRemoveAll(completion: (()->Swift.Void)? = nil) {
        (self.rootViewController as? UINavigationController)?.viewControllers.removeAll()
        // Run Closure
        completion?()
    }
    
    /// Pop to root view controller
    public func popToRoot(completion: (()->Swift.Void)? = nil) {
        (self.rootViewController as? UINavigationController)?.viewControllers.remove(at: 0)
        // Run Closure
        completion?()
    }
}

public extension RootViewCoordinatorProvider {
    
    /// Attach view in rootViewController
    public func attach(children: UIViewController, bounds: CGRect? = nil, completion: (() -> Swift.Void)? = nil) {
        // Configure Child View
        children.view.frame = bounds ?? self.rootViewController.view.bounds
        
        // Add a view in parent view
        self.rootViewController.view.addSubview(children.view)
        self.rootViewController.view.bringSubview(toFront: children.view)
        
        // Run closure
        completion?()
    }
    
    /// Dettach view in rootViewController
    public func detach(children: UIViewController, completion: (() -> Swift.Void)? = nil) {
        // remove a view in parent view
        children.view.removeFromSuperview()
        
        // Run closure
        completion?()
    }
}

public extension RootViewCoordinator {
    /// Add coordinator in root coordinator
    public func add(coordinator: RootViewCoordinator, bounds: CGRect? = nil, completion: (() -> Swift.Void)? = nil) {
        coordinator.parentRootViewCoordinatorProvider = self
        self.add(childCoordinator: coordinator)
        self.add(children: coordinator.rootViewController, bounds: bounds, completion: completion)
    }
    
    /// Remove coordinator
    public func remove(coordinator: RootViewCoordinator, completion: (() -> Swift.Void)? = nil) {
        coordinator.parentRootViewCoordinatorProvider = nil
        self.remove(childCoordinator: coordinator)
        self.remove(children: coordinator.rootViewController, completion: completion)
    }
    
    /// Present view controller in rootViewController
    public func present(coordinator: RootViewCoordinator, animated: Bool = true, completion: (()->Swift.Void)? = nil) {
        coordinator.parentRootViewCoordinatorProvider = self
        self.add(childCoordinator: coordinator)
        self.present(to: coordinator.rootViewController, animated: animated, completion: completion)
    }
    
    public func dismiss(coordinator: RootViewCoordinator, animated: Bool = true, completion: (()->Swift.Void)? = nil) {
        coordinator.parentRootViewCoordinatorProvider = nil
        self.remove(childCoordinator: coordinator)
        coordinator.rootViewController.dismiss(animated: animated, completion: completion)
    }
    
    /// Push coordinator in rootViewController
    public func addFromNavigation(to coordinator: RootViewCoordinator, animated: Bool = true, completion: (()->Swift.Void)? = nil) {
        coordinator.parentRootViewCoordinatorProvider = self
        self.add(childCoordinator: coordinator)
        self.push(to: coordinator.rootViewController, animated: animated, completion: completion)
    }
}

extension RootViewCoordinator {
    internal func remove(viewController: UIViewController, isChild: Bool = false) {
        if viewController is UINavigationController {
            (self.rootViewController as? UINavigationController)?.remove(viewController: viewController)

        } else if viewController is UITabBarController {
            (self.rootViewController as? UITabBarController)?.remove(viewController: viewController)
        } else if viewController is UISplitViewController {
            if isChild {
                (self.rootViewController as? UISplitViewController)?.remove(childController: viewController)
            } else {
                (self.rootViewController as? UISplitViewController)?.remove(viewController: viewController)
            }
        }
    }
}

