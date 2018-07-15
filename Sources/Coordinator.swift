//
//  Coordinator.swift
//  Coordinator
//
//  Created by Amine Bensalah on 06/03/2018.
//

import Foundation

/// The Coordinator protocol
public protocol Coordinator: class {
    /// The cooridnator name
    var name: String { get }
    
    /// The array containing any child Coordinators
    var childCoordinators: [Coordinator] { get set }
}

extension Coordinator {
    public var name: String {
        return String(describing: self)
    }
    
    /// Add a child coordinator to the parent
    public func add(coordinator children: Coordinator) {
        self.childCoordinators.append(children)
    }
    
    /// Remove a child coordinator from the parent
    public func remove(coordinator children: Coordinator) {
        self.childCoordinators = self.childCoordinators.filter { $0 !== children }
    }
}

extension Coordinator where Self: Equatable {
    public static func == (lhs: Self, rhs: Self) -> Bool {
        return lhs.name == rhs.name && lhs.childCoordinators.count == rhs.childCoordinators.count
    }
}
