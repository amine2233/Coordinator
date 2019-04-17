#if canImport(UIKit)
import UIKit

#if !os(watchOS)
extension UINavigationController {
    /// Removes and returns the viewController.
    ///
    ///     All the viewController following the specified position are moved up to
    ///     close the gap.
    ///
    /// - Parameters:
    ///     - viewController: The view controller to remove. `viewController` must be a valid index of the array.
    /// - Returns:
    ///     The element or nil.
    ///
    /// - Complexity: O(*n*), where *n* is the length of the array.
    @discardableResult
    public func remove(controller viewController: UIViewController) -> UIViewController? {
        if let index = self.viewControllers.firstIndex(where: { $0 == viewController }) {
            return self.viewControllers.remove(at: index)
        }
        return nil
    }
}

extension UITabBarController {
    /// Removes and returns the viewController.
    ///
    ///     All the viewController following the specified position are moved up to
    ///     close the gap.
    ///
    /// - Parameter viewController: The view controller to remove. `viewController` must
    ///   be a valid index of the array.
    /// - Returns: The element or nil.
    ///
    /// - Complexity: O(*n*), where *n* is the length of the array.
    @discardableResult
    public func remove(controller viewController: UIViewController) -> UIViewController? {
        if let index = self.viewControllers?.firstIndex(where: { $0 == viewController }) {
            return self.viewControllers?.remove(at: index)
        }
        return nil
    }
}

extension UISplitViewController {
    /// Removes and returns the viewController.
    ///
    ///     All the viewController following the specified position are moved up to
    ///     close the gap.
    ///
    /// - Parameter viewController: The view controller to remove. `viewController` must
    ///   be a valid index of the array.
    /// - Returns: The element or nil.
    ///
    /// - Complexity: O(*n*), where *n* is the length of the array.
    @discardableResult
    public func remove(controller viewController: UIViewController) -> UIViewController? {
        if let index = self.viewControllers.firstIndex(where: { $0 == viewController }) {
            return self.viewControllers.remove(at: index)
        }
        return nil
    }
    
    /// Removes and returns the viewController.
    ///
    ///     All the viewController following the specified position are moved up to
    ///     close the gap.
    ///
    /// - Parameter childController: The view controller to remove. `viewController` must
    ///   be a valid index of the array.
    /// - Returns: The element or nil.
    ///
    /// - Complexity: O(*n*), where *n* is the length of the array.
    @discardableResult
    public func remove(childController: UIViewController) -> UIViewController? {
        if let index = self.children.firstIndex(where: { $0 == childController }) {
            return self.viewControllers.remove(at: index)
        }
        return nil
    }
}

extension UIPageViewController { }
#endif

#endif
