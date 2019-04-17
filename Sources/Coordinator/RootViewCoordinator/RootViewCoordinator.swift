#if canImport(Foundation)
import Foundation

/// The Root view coordinator, all coordinator must implement this protocol
public protocol RootViewCoordinator: Coordinator, RootViewCoordinatorProvider {
    
    /// The RootViewCoordinatorProvider parent for get a reference for the parent
    var parentRootViewCoordinator: RootViewCoordinator? { get set }
    
    /// The start method
    func start(_ completion: (()->Void)?)
    
    /// The close method
    func stop(_ completion: (()->Void)?)
}

/// Extension implement `Equatable`
extension RootViewCoordinator where Self: Equatable {
    
    /// A type that can be compared for value equality.
    ///
    /// Types that conform to the `Equatable` protocol can be compared for equality
    /// using the equal-to operator (`==`) or inequality using the not-equal-to
    /// operator (`!=`).
    public static func == (lhs: Self, rhs: Self) -> Bool {
        return lhs == rhs
    }
}

/// Extension implement `Hashable`
extension RootViewCoordinator where Self: Hashable {
    
    /// Hashes the essential components of this value by feeding them into the
    /// given hasher.
    public var hashValue: Int {
        return rootViewController.hashValue + name.hashValue
    }
}

/// Extension `RootViewCoordinator`
extension RootViewCoordinator {
    
    /// Implement default stop method
    public func stop(_ completion: (()->Void)? = nil) {
        completion?()
    }
}
#endif
