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
    
    /// Add view controller in rootViewController
    public func add(controller children: NSViewController, completion: (() -> Swift.Void)? = nil, bounds: CGRect? = nil) {
        // Add Child View Controller
        self.rootViewController.addChildViewController(children)
        
        // Configure Child View
        children.view.frame = bounds ?? self.rootViewController.view.bounds
        
        // Add Child View as Subview
        self.rootViewController.view.addSubview(children.view)
        
        // Run closure
        completion?()
    }
    
    /// Remove view controller
    public func remove(controller children: NSViewController, completion: (() -> Swift.Void)? = nil) {
        // Remove Child View From Superview
        children.view.removeFromSuperview()
        
        // Notify Child View Controller
        children.removeFromParentViewController()
        
        // Run completion
        completion?()
    }
}

/// Extension for add or remove Coordinator
public extension RootViewCoordinator {
    
    /// Add view controller in rootViewController
    public func add(to children: RootViewCoordinator, completion: (() -> Swift.Void)? = nil, bounds: CGRect? = nil) {
        children.parentRootViewCoordinatorProvider = self
        self.add(childCoordinator: children)
        self.add(children: children.rootViewController, completion: completion, bounds: bounds)
    }
    
    /// Remove view controller
    public func remove(from children: RootViewCoordinator, completion: (() -> Swift.Void)? = nil) {
        children.parentRootViewCoordinatorProvider = nil
        self.remove(children: children)
        self.remove(children: children.rootViewController, completion: completion)
    }
}
