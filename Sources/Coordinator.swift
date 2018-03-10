//
//  Coordinator.swift
//  Coordinator
//
//  Created by Amine Bensalah on 06/03/2018.
//

import Foundation

/// The Coordinator protocol
public protocol Coordinator: class {
    
    /// The array containing any child Coordinators
    var childCoordinators: [Coordinator] { get set }
}

public extension Coordinator {
    
    /// Add a child coordinator to the parent
    public func add(childCoordinator: Coordinator) {
        self.childCoordinators.append(childCoordinator)
    }
    
    /// Remove a child coordinator from the parent
    public func remove(childCoordinator: Coordinator) {
        self.childCoordinators = self.childCoordinators.filter { $0 !== childCoordinator }
    }
}
