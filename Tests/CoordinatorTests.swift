//
//  Coordinator_iOSTests.swift
//  Coordinator iOSTests
//
//  Created by Amine Bensalah on 06/03/2018.
//

@testable import Coordinator
import XCTest

class CoordinatorTests: XCTestCase {
    
    class RootCoordinator: Coordinator {
        var childCoordinators: [Coordinator] = []
    }
    
    class OneChildCoordinator: RootCoordinator {}
    class TwoChildCoordinator: RootCoordinator {}
    class OneChildOfChildCoordinator: RootCoordinator {}
    
    override func setUp() {
        super.setUp()
    }

    override func tearDown() {
        super.tearDown()
    }

    func testNameCoordinator() {
        let rootCoordinator = RootCoordinator()
        XCTAssertEqual(rootCoordinator.name, "RootCoordinator")
    }
    
    func testAddCoordinator() {
        let rootCoordinator = RootCoordinator()
        let oneChildCoordinator = OneChildCoordinator()
        let twoChildCoordinator = TwoChildCoordinator()
        let oneChildOfChildCoordinator = OneChildOfChildCoordinator()
        
        rootCoordinator.add(coordinator: oneChildCoordinator)
        rootCoordinator.add(coordinator: twoChildCoordinator)
        oneChildCoordinator.add(coordinator: oneChildOfChildCoordinator)
        
        XCTAssertEqual(rootCoordinator.childCoordinators.count, 2)
        XCTAssertEqual(oneChildCoordinator.childCoordinators.count, 1)
    }
    
    func testRemoveCoordinator() {
        
        let rootCoordinator = RootCoordinator()
        let oneChildCoordinator = OneChildCoordinator()
        let twoChildCoordinator = TwoChildCoordinator()
        let oneChildOfChildCoordinator = OneChildOfChildCoordinator()
        
        rootCoordinator.add(coordinator: oneChildCoordinator)
        rootCoordinator.add(coordinator: twoChildCoordinator)
        oneChildCoordinator.add(coordinator: oneChildOfChildCoordinator)
        
        oneChildCoordinator.remove(coordinator: oneChildOfChildCoordinator)
        XCTAssertEqual(oneChildCoordinator.childCoordinators.count, 0)
        
        rootCoordinator.remove(coordinator: oneChildCoordinator)
        XCTAssertEqual(rootCoordinator.childCoordinators.count, 1)
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        measure {
            // Put the code you want to measure the time of here.
        }
    }
}
