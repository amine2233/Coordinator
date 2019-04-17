#if os(OSX)
import class AppKit.NSViewController
public typealias ViewController = NSViewController
#elseif os(iOS) || os(tvOS)
import class UIKit.UIViewController
public typealias ViewController = UIViewController
#elseif os(watchOS)
import class WatchKit.WKInterfaceController
public typealias ViewController = WKInterfaceController
#endif

/// Root view Coordinator
public protocol RootViewCoordinatorProvider: class {
    
    /// The root view controller, the start point of each Coordinator, can represent the container
    var rootViewController: ViewController { get }
}

/// Extension implement `Equatable`
extension RootViewCoordinatorProvider where Self: Equatable {
    
    /// A type that can be compared for value equality.
    ///
    /// Types that conform to the `Equatable` protocol can be compared for equality
    /// using the equal-to operator (`==`) or inequality using the not-equal-to
    /// operator (`!=`).
    public static func == (lhs: Self, rhs: Self) -> Bool {
        return lhs.rootViewController == rhs.rootViewController
    }
}

/// Extension implement `Hashable`
extension RootViewCoordinatorProvider where Self: Hashable {
    
    /// Hashes the essential components of this value by feeding them into the
    /// given hasher.
    public func hash(into hasher: inout Hasher) {
        hasher.combine(self.rootViewController)
    }
}
