import UIKit

extension UINavigationController {
    
    /// Removes and returns the viewController.
    ///
    /// All the viewController following the specified position are moved up to
    /// close the gap.
    ///
    /// - Parameter viewController: The view controller to remove. `viewController` must
    ///   be a valid index of the array.
    /// - Returns: The element or nil.
    ///
    /// - Complexity: O(*n*), where *n* is the length of the array.
    @discardableResult
    public func remove(viewController: UIViewController) -> UIViewController? {
        if let index = self.viewControllers.index(where: { return $0 === viewController }) {
            return self.viewControllers.remove(at: index)
        }
        return nil
    }
}

extension UITabBarController {
    /// Removes and returns the viewController.
    ///
    /// All the viewController following the specified position are moved up to
    /// close the gap.
    ///
    /// - Parameter viewController: The view controller to remove. `viewController` must
    ///   be a valid index of the array.
    /// - Returns: The element or nil.
    ///
    /// - Complexity: O(*n*), where *n* is the length of the array.
    @discardableResult
    public func remove(viewController: UIViewController) -> UIViewController? {
        if let index = self.viewControllers?.index(where: { return $0 === viewController }) {
            return self.viewControllers?.remove(at: index)
        }
        return nil
    }
}

extension UISplitViewController {
    /// Removes and returns the viewController.
    ///
    /// All the viewController following the specified position are moved up to
    /// close the gap.
    ///
    /// - Parameter viewController: The view controller to remove. `viewController` must
    ///   be a valid index of the array.
    /// - Returns: The element or nil.
    ///
    /// - Complexity: O(*n*), where *n* is the length of the array.
    @discardableResult
    public func remove(viewController: UIViewController) -> UIViewController? {
        if let index = self.viewControllers.index(where: { return $0 === viewController }) {
            return self.viewControllers.remove(at: index)
        }
        return nil
    }
    
    /// Removes and returns the viewController.
    ///
    /// All the viewController following the specified position are moved up to
    /// close the gap.
    ///
    /// - Parameter viewController: The view controller to remove. `viewController` must
    ///   be a valid index of the array.
    /// - Returns: The element or nil.
    ///
    /// - Complexity: O(*n*), where *n* is the length of the array.
    @discardableResult
    public func remove(childController: UIViewController) -> UIViewController? {
        if let index = self.childViewControllers.index(where: { return $0 === childController }) {
            return self.viewControllers.remove(at: index)
        }
        return nil
    }
}
