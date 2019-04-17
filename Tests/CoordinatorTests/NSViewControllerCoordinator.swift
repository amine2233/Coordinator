//
//  NSViewControllerCoordinator.swift
//  Coordinator macOSTests
//
//  Created by Amine Bensalah on 27/09/2018.
//

import XCTest
@testable import Coordinator

class NSViewControllerCoordinator: XCTestCase {
    
    class TestViewController: NSViewController {
        override func loadView() {
            self.view = NSView()
        }
    }
    
    class TestRootCoordinator : NSObject, RootViewCoordinator {
        
        var childCoordinators: [Coordinator] = []
        var parentRootViewCoordinator: RootViewCoordinator?
        var rootViewController: NSViewController = TestViewController()
        
        override init() {
            let frame = CGRect(origin: .zero, size: CGSize(width: 100, height: 100))
            rootViewController.view.frame = frame
        }
        
        func start(_ completion: (() -> Void)?) {
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
        testRootCoordinator.removeChildCoordinator(testChildOneCoordinator)
    }
    
    func testAddCoordinator() {
        
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
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
}
