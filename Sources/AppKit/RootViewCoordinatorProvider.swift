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
    public func add(children: NSViewController, frame: CGRect? = nil) {
        // Add Child View Controller
        self.rootViewController.addChildViewController(children)
        
        // Add Child View as Subview
        self.rootViewController.view.addSubview(children.view)
        
        // Configure Child View
        children.view.frame = frame ?? self.rootViewController.view.bounds
    }
    
    public func remove(children: NSViewController) {
        // Remove Child View From Superview
        children.view.removeFromSuperview()
        
        // Notify Child View Controller
        children.removeFromParentViewController()
    }
}

public protocol RootViewCoordinator: Coordinator, RootViewCoordinatorProvider { }
