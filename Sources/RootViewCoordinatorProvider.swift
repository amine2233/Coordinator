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

public protocol RootViewCoordinatorProvider: class {
    var parentRootViewCoordinatorProvider: RootViewCoordinatorProvider? { get set }
    var rootViewController: ViewController { get }
}

public protocol RootViewCoordinator: Coordinator, RootViewCoordinatorProvider {}

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
