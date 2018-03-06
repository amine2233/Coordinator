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

extension RootViewCoordinatorProvider {
    func add(children: UIViewController, frame: CGRect? = nil) {
        // Add Child View Controller
        self.rootViewController.addChildViewController(children)
        
        // Add Child View as Subview
        self.rootViewController.view.addSubview(children.view)
        
        // Configure Child View
        children.view.frame = frame ?? self.rootViewController.view.bounds
        children.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        // Notify Child View Controller
        children.didMove(toParentViewController: self.rootViewController)
    }
    
    func remove(children: UIViewController) {
        // Notify Child View Controller
        children.willMove(toParentViewController: nil)
        
        // Remove Child View From Superview
        children.view.removeFromSuperview()
        
        // Notify Child View Controller
        children.removeFromParentViewController()
    }
    
    func present(to viewController: UIViewController, animated: Bool = true, completion: (()->Swift.Void)? = nil ) {
        self.rootViewController.present(viewController, animated: animated, completion: completion)
    }
    
    func push(to viewController: UIViewController, animated: Bool = true) {
        self.rootViewController.navigationController?.pushViewController(viewController, animated: animated)
    }
    
    func pop(to viewController: UIViewController? = nil, animated: Bool = true) {
        if let viewController = viewController {
            self.rootViewController.navigationController?.popToViewController(viewController, animated: animated)
        } else {
            self.rootViewController.navigationController?.popViewController(animated: animated)
        }
    }
    
    func popToRoot(animated: Bool = true) {
        self.rootViewController.navigationController?.popToRootViewController(animated: animated)
    }
}

typealias RootViewCoordinator = Coordinator & RootViewCoordinatorProvider
