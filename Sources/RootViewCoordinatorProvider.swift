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
    
    /// The RootViewCoordinatorProvider parent for get a reference for the parent
    var parentRootViewCoordinatorProvider: RootViewCoordinatorProvider? { get set }
    
    /// The root view controller, the start point of each Coordinator, can represent the container
    var rootViewController: ViewController { get }
}

/// The Root view coordinator, all coordinator must implement this protocol
public protocol RootViewCoordinator: Coordinator, RootViewCoordinatorProvider {}
