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

public extension RootViewCoordinatorProvider {
    
    /// Add view controller in rootViewController
    public func add(children: NSViewController, completion: (() -> Swift.Void)? = nil, bounds: CGRect? = nil) {
        // Add Child View Controller
        self.rootViewController.addChildViewController(children)
        
        // Add Child View as Subview
        self.rootViewController.view.addSubview(children.view)
        
        // Configure Child View
        children.view.frame = bounds ?? self.rootViewController.view.bounds
        
        // Run closure
        completion?()
    }
    
    /// Remove view controller
    public func remove(children: NSViewController, completion: (() -> Swift.Void)? = nil) {
        // Remove Child View From Superview
        children.view.removeFromSuperview()
        
        // Notify Child View Controller
        children.removeFromParentViewController()
        
        // Run completion
        completion?()
    }
}

public protocol RootViewCoordinator: Coordinator, RootViewCoordinatorProvider { }
