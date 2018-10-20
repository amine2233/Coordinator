#if canImport(Foundation)
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
        return String(describing: self).lastStringComponents(separatedBy: ".")
    }
    
    /**
     Add a child coordinator to the parent
     
     - Parameters:
        - childrenCoordinator: coordinator we will add in parent coordinator
     */
    public func add(coordinator children: Coordinator) {
        self.childCoordinators.append(children)
    }
    
    /**
     Remove a child coordinator from the parent
     
     - Parameters:
        - childrenCoordinator: coordinator we will remove in parent coordinator
     */
    public func remove(coordinator children: Coordinator) {
        self.childCoordinators = self.childCoordinators.filter { $0 !== children }
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

extension Coordinator where Self: Hashable {
    /// The hash value.
    public var hashValue: Int {
        return name.hashValue
    }
}

extension String {
    
    func lastStringComponents(separatedBy character: String) -> String {
        return self.components(separatedBy: character).last ?? self
    }
}
#endif
