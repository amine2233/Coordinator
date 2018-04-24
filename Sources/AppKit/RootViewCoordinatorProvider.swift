//
//  RootViewCoordinatorProvider.swift
//  Coordinator macOS
//
//  Created by Amine Bensalah on 06/03/2018.
//

import AppKit

public protocol RootViewCoordinatorProvider: class {
    var parentRootViewCoordinatorProvider: RootViewCoordinatorProvider? { get set }
    var rootViewController: NSViewController { get }
}

public protocol RootViewCoordinator: Coordinator, RootViewCoordinatorProvider { }

public extension RootViewCoordinatorProvider {
    
    /**
     Add children view controller in rootViewController coordinator
     
     - Parameter viewController: View controller will add in rootViewController of coordinator
     - Parameter bounds: Size of view in view of rootViewController coodrinator
     - Parameter completion: completion run after add children view controller
     */
    public func addChildrenViewController(_ viewController: NSViewController, bounds: CGRect? = nil, completion: (() -> Swift.Void)? = nil) {
        // Add Child View Controller
        self.rootViewController.addChildViewController(viewController)
        
        // Configure Child View
        viewController.view.frame = bounds ?? self.rootViewController.view.bounds
        
        // Add Child View as Subview
        self.rootViewController.view.addSubview(viewController.view)
        
        // Run closure
        completion?()
    }
    
    /**
     Remove children view controller in rootViewController
     
     - Parameter viewController: View controller will removed in rootViewController of coordinator
     - Parameter completion: completion run after remove children view controller
     */
    public func removeChildrenViewController(_ viewController: NSViewController, completion: (() -> Swift.Void)? = nil) {
        // Remove Child View From Superview
        viewController.view.removeFromSuperview()
        
        // Notify Child View Controller
        viewController.removeFromParentViewController()
        
        // Run completion
        completion?()
    }
}

/// Extension for add or remove Coordinator
public extension RootViewCoordinator {
    
    /**
     Attach view of viewController of childrenCoordinator in rootViewController of parentCoordinator,
     
     - Parameter childrenCoordinator: childrenCoordinator we will add rootViewController in rootViewController of parent coordinator
     - Parameter bounds: Size of view in view of rootViewController coodrinator
     - Parameter completion: completion run after add children view controller
     */
    public func addChildrenCoordinator(_ childrenCoordinator: RootViewCoordinator, bounds: CGRect? = nil, completion: (() -> Swift.Void)? = nil) {
        childrenCoordinator.parentRootViewCoordinatorProvider = self
        self.add(childrenCoordinator)
        self.addChildrenViewController(childrenCoordinator.rootViewController, bounds: bounds, completion: completion)
    }
    
    /**
     Remove rootViewController of coordinator in parent rootViewController coordinator,
     
     - Parameter childrenCoordinator: childrenCoordinator we will remove rootViewController in rootViewController parent coordinator
     - Parameter completion: completion run after add children view controller
     */
    public func removeChildrenCoordinator(_ childrenCoordinator: RootViewCoordinator, completion: (() -> Swift.Void)? = nil) {
        childrenCoordinator.parentRootViewCoordinatorProvider = nil
        self.remove(childrenCoordinator)
        self.removeChildrenViewController(childrenCoordinator.rootViewController, completion: completion)
    }
}
