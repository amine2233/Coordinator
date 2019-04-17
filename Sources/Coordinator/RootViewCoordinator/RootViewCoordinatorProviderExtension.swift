#if canImport(UIKit)
import UIKit

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
    
    public var pageViewController: UIPageViewController? {
        return self.rootViewController as? UIPageViewController
    }
}
#endif
#endif
