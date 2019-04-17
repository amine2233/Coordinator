//
//  UIViewControllerCoordinatorTests.swift
//  Coordinator iOS
//
//  Created by BENSALA on 17/04/2019.
//

import XCTest
@testable import Coordinator

class UIViewControllerCoordinatorTests: XCTestCase {
    
    class TestViewController: UIViewController {
        var name: String?
    }
    
    class TestRootCoordinator : NSObject, RootViewCoordinator {
        var childCoordinators: [Coordinator] = []
        var parentRootViewCoordinator: RootViewCoordinator?
        var rootViewController: UIViewController = TestViewController()
        
        override init() {
            let frame = CGRect(origin: .zero, size: CGSize(width: 100, height: 100))
            rootViewController.view.frame = frame
        }
        
        func start(_ completion: (() -> Void)? = nil) {
            completion?()
        }
    }
    
    class TestNavigationRootCoordinator: NSObject, RootViewCoordinator {
        var childCoordinators: [Coordinator] = []
        var parentRootViewCoordinator: RootViewCoordinator?
        var rootViewController: UIViewController = UINavigationController()
        
        override init() {
            let frame = CGRect(origin: .zero, size: CGSize(width: 100, height: 100))
            rootViewController.view.frame = frame
        }
        
        func start(_ completion: (() -> Void)? = nil) {
            completion?()
        }
    }
    
    class TestChildOneCoordinator: TestRootCoordinator {}
    class TestChildTwoCoordinator: TestRootCoordinator {}
    class TestChildThreeCoordinator: TestRootCoordinator {}
    
    var testRootCoordinator = TestRootCoordinator()
    var testChildOneCoordinator = TestChildOneCoordinator()
    var testChildTwoCoordinator = TestChildTwoCoordinator()
    var testChildThreeCoordinator = TestChildThreeCoordinator()
    
    override func setUp() {
        testRootCoordinator.addChildCoordinator(testChildOneCoordinator)
    }
    
    override func tearDown() {
        testChildOneCoordinator.removeChildCoordinator(testRootCoordinator)
    }
    
    public func testAddCoordinator() {
        
        XCTAssertNotNil(testChildOneCoordinator.parentRootViewCoordinator)
        XCTAssertEqual(testRootCoordinator.childCoordinators.count, 1)
        XCTAssertTrue(testRootCoordinator.name.contains("TestRootCoordinator"))
        XCTAssertTrue(testRootCoordinator.isEqual(testChildOneCoordinator.parentRootViewCoordinator))
        
        // Add second coordinator
        testRootCoordinator.addChildCoordinator(testChildTwoCoordinator)
        
        XCTAssertNotNil(testChildTwoCoordinator.parentRootViewCoordinator)
        XCTAssertEqual(testRootCoordinator.childCoordinators.count, 2)
        XCTAssertTrue(testRootCoordinator.isEqual(testChildTwoCoordinator.parentRootViewCoordinator))
        
        // Add second coordinator
        testChildTwoCoordinator.addChildCoordinator(testChildThreeCoordinator)
        
        XCTAssertNotNil(testChildThreeCoordinator.parentRootViewCoordinator)
        XCTAssertEqual(testChildTwoCoordinator.childCoordinators.count, 1)
        XCTAssertTrue(testChildTwoCoordinator.isEqual(testChildThreeCoordinator.parentRootViewCoordinator))
    }
    
    func testRemoveCoordinator() {
        testRootCoordinator.removeChildCoordinator(testChildOneCoordinator)
        
        XCTAssertNil(testChildOneCoordinator.parentRootViewCoordinator)
        XCTAssertEqual(testRootCoordinator.childCoordinators.count, 0)
    }
    
    func testAddController() {
        // Test adding simple controller
        let controller = TestViewController()
        testChildThreeCoordinator.addChild(controller)
        let frame = CGRect(origin: .zero, size: CGSize(width: 100, height: 100))
        
        XCTAssertNotNil(controller.parent)
        XCTAssertEqual(controller.view.frame, frame)
        XCTAssertEqual(testChildThreeCoordinator.rootViewController.view.subviews.count, 1)
        
        // Test adding controller with frame
        let controller2 = TestViewController()
        let frame2 = CGRect(origin: .zero, size: CGSize(width: 50, height: 57))
        
        testChildThreeCoordinator.addChild(controller2, bounds: frame2)
        
        XCTAssertNotNil(controller2.parent)
        XCTAssertEqual(controller2.view.frame, frame2)
        XCTAssertEqual(testChildThreeCoordinator.rootViewController.view.subviews.count, 2)
        
        var testCompletion = false
        
        // Test adding controller with frame and completion
        let controller3 = TestViewController()
        let frame3 = CGRect(origin: .zero, size: CGSize(width: 300, height: 27))
        let expectation = self.expectation(description: "Adding")
        
        testChildThreeCoordinator.addChild(controller3, bounds: frame3, completion: {
            testCompletion = true
            expectation.fulfill()
        })
        waitForExpectations(timeout: 5, handler: nil)
        
        XCTAssertNotNil(controller3.parent)
        XCTAssertEqual(controller3.view.frame, frame3)
        XCTAssertEqual(testChildThreeCoordinator.rootViewController.view.subviews.count, 3)
        XCTAssertTrue(testCompletion)
    }
    
    func testRemoveController() {
        // Test removing simple controller
        let controller = TestViewController()
        let controller2 = TestViewController()
        testChildThreeCoordinator.addChild(controller)
        testChildThreeCoordinator.addChild(controller2)
        
        XCTAssertNotNil(controller.parent)
        XCTAssertNotNil(controller2.parent)
        XCTAssertEqual(testChildThreeCoordinator.rootViewController.view.subviews.count, 2)
        
        testChildThreeCoordinator.removeChild(controller)
        XCTAssertNil(controller.parent)
        XCTAssertEqual(testChildThreeCoordinator.rootViewController.view.subviews.count, 1)
        
        // Test removing controller with completion
        var testCompletion = false
        let expectation = self.expectation(description: "Removing")
        testChildThreeCoordinator.removeChild(controller2) {
            testCompletion = true
            expectation.fulfill()
        }
        waitForExpectations(timeout: 5, handler: nil)
        
        XCTAssertTrue(testCompletion)
        XCTAssertNil(controller2.parent)
        XCTAssertEqual(testChildThreeCoordinator.rootViewController.view.subviews.count, 0)
    }
    
    func testAddNavigationViewController() {
        let controller = TestViewController()
        let navigationRootCoordinator = TestNavigationRootCoordinator()
        
        navigationRootCoordinator.addChildInNavigation(controller)
        
        XCTAssertNotNil(controller.parent)
        XCTAssertEqual(navigationRootCoordinator.rootViewController.view.subviews.count, 2)
        XCTAssertNotNil(navigationRootCoordinator.navigationViewController)
        
        if let navigationViewController = navigationRootCoordinator.navigationViewController {
            XCTAssertEqual(navigationViewController.nameOfClass, UINavigationController.nameOfClass)
            XCTAssertEqual(navigationViewController.viewControllers.count, 1)
        }
        
        let controller2 = TestViewController()
        navigationRootCoordinator.addChildInNavigation(controller2)
        
        if let navigationViewController = navigationRootCoordinator.navigationViewController {
            XCTAssertEqual(navigationViewController.viewControllers.count, 2)
        }
    }
    
    func testPopRemoveAllNavigationViewController() {
        let navigationRootCoordinator = TestNavigationRootCoordinator()
        
        let controller = TestViewController()
        navigationRootCoordinator.addChildInNavigation(controller)
        
        let controller2 = TestViewController()
        navigationRootCoordinator.addChildInNavigation(controller2)
        
        if let navigationViewController = navigationRootCoordinator.navigationViewController {
            XCTAssertEqual(navigationViewController.viewControllers.count, 2)
        }
        
        navigationRootCoordinator.popRemoveAllInNavigation()
        
        if let navigationViewController = navigationRootCoordinator.navigationViewController {
            XCTAssertEqual(navigationViewController.viewControllers.count, 0)
        }
    }
    
    func testPopToRootAllNavigationViewController() {
        let navigationRootCoordinator = TestNavigationRootCoordinator()
        
        let controller = TestViewController()
        controller.name = "TestViewController1"
        navigationRootCoordinator.addChildInNavigation(controller)
        
        let controller2 = TestViewController()
        controller2.name = "TestViewController2"
        navigationRootCoordinator.addChildInNavigation(controller2)

        let controller3 = TestViewController()
        controller3.name = "TestViewController3"
        navigationRootCoordinator.addChildInNavigation(controller3)

        if let navigationViewController = navigationRootCoordinator.navigationViewController {
            XCTAssertEqual(navigationViewController.viewControllers.count, 3)
        }
        
        navigationRootCoordinator.popToRootInNavigation()
        
        if let navigationViewController = navigationRootCoordinator.navigationViewController {
            XCTAssertEqual(navigationViewController.viewControllers.count, 1)
            XCTAssertEqual((navigationViewController.viewControllers.last as! TestViewController).name! , "TestViewController1")
        }
    }
}

extension NSObject {
    public class var nameOfClass: String{
        return NSStringFromClass(self).components(separatedBy: ".").last!
    }
    
    public var nameOfClass: String{
        return NSStringFromClass(type(of: self)).components(separatedBy: ".").last!
    }
}
