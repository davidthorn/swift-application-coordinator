//
//  ApplicationCoordinatorTests.swift
//  ApplicationCoordinatorTests
//
//  Created by Thorn, David on 04.04.20.
//  Copyright © 2020 Thorn, David. All rights reserved.
//

import XCTest
@testable import ApplicationCoordinator

class ApplicationCoordinatorTests: XCTestCase {

    func testRootViewController() {
        let rootViewController = UIViewController()
        let otherViewController = UIViewController()
        otherViewController.title = "Other controller"
        let coordinator = AppDelegateCoordinator(rootViewController: rootViewController)
        XCTAssertEqual(coordinator.rootViewController, rootViewController)
        XCTAssertNotEqual(coordinator.rootViewController, otherViewController)
    }

    func testCreateWindow() {
        let rootViewController = UIViewController()
        let otherViewController = UIViewController()
        otherViewController.title = "Other controller"
        let coordinator = AppDelegateCoordinator(rootViewController: rootViewController)
        XCTAssertNil(coordinator.window)
        let window = coordinator.createWindow()
        XCTAssertEqual(window, coordinator.createWindow())
        XCTAssertEqual(window, coordinator.window)
        XCTAssertEqual(window.rootViewController, rootViewController)
    }

}
