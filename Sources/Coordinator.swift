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
    
    /// The cooridnator name
    public var name: String {
        return String(describing: self)
    }
    
    /**
     Add a child coordinator to the parent
     
     - Parameter childrenCoordinator: coordinator we will add in parent coordinator
     */
    public func add(_ childCoordinator: Coordinator) {
        self.childCoordinators.append(childCoordinator)
    }
    
    /**
     Remove a child coordinator from the parent
     
     - Parameter childrenCoordinator: coordinator we will remove in parent coordinator
     */
    public func remove(_ childCoordinator: Coordinator) {
        self.childCoordinators = self.childCoordinators.filter { $0 !== childCoordinator }
    }
}

extension Coordinator where Self: Equatable {
    
    /// Returns a Boolean value indicating whether two `Coordinator` are equal.
    ///
    /// Equality is the inverse of inequality. For any values `lhs` and `rhs`,
    /// `lhs == rhs` implies that `lhs != rhs` is `false`.
    ///
    /// - Parameters:
    ///   - lhs: A value to compare.
    ///   - rhs: Another value to compare.
    public static func == (lhs: Self, rhs: Self) -> Bool {
        return lhs.name == rhs.name && lhs.childCoordinators.count == rhs.childCoordinators.count
    }
}
