#if os(OSX)
import AppKit.NSViewController
public typealias ViewController = NSViewController
#elseif os(iOS) || os(tvOS)
import UIKit.UIViewController
public typealias ViewController = UIViewController
#elseif os(watchOS)
import WatchKit.WKInterfaceController
public typealias ViewController = WKInterfaceController
#endif

/// Root view Coordinator
public protocol RootViewCoordinatorProvider: class {
    /// The root view controller, the start point of each Coordinator, can represent the container
    var rootViewController: ViewController { get }
}

#if os(iOS) || os(tvOS)
extension RootViewCoordinatorProvider {
    /// The root navigation controller
    public var navigationViewController: UINavigationController? {
        return self.rootViewController as? UINavigationController
    }
    
    /// The root tabbar controller
    public var tabBarController: UITabBarController? {
        return self.rootViewController as? UITabBarController
    }
    
    /// The root splitview controller
    public var splitViewController: UISplitViewController? {
        return self.rootViewController as? UISplitViewController
    }
}
#endif

/// The Root view coordinator, all coordinator must implement this protocol
public protocol RootViewCoordinator: Coordinator, RootViewCoordinatorProvider {
    
    /// The RootViewCoordinatorProvider parent for get a reference for the parent
    var parentRootViewCoordinator: RootViewCoordinator? { get set }

    /// The start method
    func start(_ completion: (()->Void)?)
    
    /// The close method
    func stop(_ completion: (()->Void)?)
}

extension RootViewCoordinatorProvider where Self: Equatable {
    public static func == (lhs: Self, rhs: Self) -> Bool {
        return lhs.rootViewController == rhs.rootViewController
    }
}

extension RootViewCoordinatorProvider where Self: Hashable {
    public var hashValue: Int {
        return rootViewController.hashValue
    }
}

extension RootViewCoordinator where Self: Equatable {
    public static func == (lhs: Self, rhs: Self) -> Bool {
        return lhs == rhs
    }
}

extension RootViewCoordinator where Self: Equatable {
    public var hashValue: Int {
        return rootViewController.hashValue + name.hashValue
    }
}
