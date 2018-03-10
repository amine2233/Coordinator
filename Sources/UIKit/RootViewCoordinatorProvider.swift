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

public extension RootViewCoordinatorProvider {
    
    /// Add view controller in rootViewController
    public func add(children: UIViewController, completion: (() -> Swift.Void)? = nil, bounds: CGRect? = nil) {
        // Add Child View Controller
        self.rootViewController.addChildViewController(children)
        
        // Add Child View as Subview
        self.rootViewController.view.addSubview(children.view)
        
        // Configure Child View
        children.view.frame = bounds ?? self.rootViewController.view.bounds
        children.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
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
    public func present(to viewController: UIViewController, animated: Bool = true, completion: (()->Swift.Void)? = nil ) {
        self.rootViewController.present(viewController, animated: animated, completion: completion)
    }
    
    /// Push view controller in rootViewController
    public func push(to viewController: UIViewController, animated: Bool = true) {
        self.rootViewController.navigationController?.pushViewController(viewController, animated: animated)
    }
    
    /// Pop view controller in an other view controller or only pop view controller
    public func pop(to viewController: UIViewController? = nil, animated: Bool = true) {
        if let viewController = viewController {
            self.rootViewController.navigationController?.popToViewController(viewController, animated: animated)
        } else {
            self.rootViewController.navigationController?.popViewController(animated: animated)
        }
    }
    
    /// Pop to root view controller
    public func popToRoot(animated: Bool = true) {
        self.rootViewController.navigationController?.popToRootViewController(animated: animated)
    }
}

public extension RootViewCoordinatorProvider {
    
    /// Attach view in rootViewController
    public func attach(children: UIViewController, completion: (() -> Swift.Void)? = nil, bounds: CGRect? = nil) {
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

public protocol RootViewCoordinator: Coordinator, RootViewCoordinatorProvider { }
