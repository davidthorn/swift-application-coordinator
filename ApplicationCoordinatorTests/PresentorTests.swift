//
//  PresentorTests.swift
//  ApplicationCoordinatorTests
//
//  Created by Thorn, David on 04.04.20.
//  Copyright © 2020 Thorn, David. All rights reserved.
//

import XCTest
@testable import ApplicationCoordinator

class PresentorTests: XCTestCase {

    func testCoordinator_asViewController() {
        let rootViewController = UIViewController()
        let coordinator = Presentor(rootViewController: rootViewController)
        XCTAssertEqual(coordinator.presentedViewControllers.count, 0)
        XCTAssertEqual(coordinator.presentationStyles.count, 0)
        XCTAssertEqual(coordinator.rootViewController, rootViewController)
        XCTAssertNil(coordinator.navigationController)
    }

    func testCoordinator_asNavigationViewController() {
        let rootViewController = UIViewController()
        let navigationController = UINavigationController(rootViewController: rootViewController)
        let coordinator = Presentor(rootViewController: navigationController)
        XCTAssertEqual(coordinator.presentedViewControllers.count, 0)
        XCTAssertEqual(coordinator.presentationStyles.count, 0)
        XCTAssertEqual(coordinator.rootViewController, navigationController)
        XCTAssertEqual(coordinator.navigationController?.topViewController, rootViewController)
        XCTAssertEqual(coordinator.navigationController?.children.count, 1)
        XCTAssertNotNil(coordinator.navigationController)
    }

    func test_NavigationController_PresentationStyle_push() {
        let childViewController = UIViewController()
        childViewController.title = "Child 1"

        let rootViewController = UIViewController()
        let navigationController = UINavigationController(rootViewController: rootViewController)
        let coordinator = Presentor(rootViewController: navigationController)

        XCTAssertNotNil(coordinator.navigationController)
        coordinator.show(viewController: childViewController, animated: false, presentationStyle: .push)
        XCTAssertEqual(coordinator.navigationController?.viewControllers.count, 2)
        XCTAssertEqual(coordinator.navigationController?.visibleViewController, childViewController)
    }

    func test_NavigationController_PresentationStyle_dismiss() {
        let childViewController = UIViewController()
        childViewController.title = "Child 1"

        let rootViewController = UIViewController()
        let navigationController = UINavigationController(rootViewController: rootViewController)
        let coordinator = Presentor(rootViewController: navigationController)

        XCTAssertNotNil(coordinator.navigationController)
        coordinator.show(viewController: childViewController, animated: false, presentationStyle: .push)
        XCTAssertEqual(coordinator.navigationController?.viewControllers.count, 2)
        XCTAssertEqual(coordinator.navigationController?.visibleViewController, childViewController)
        coordinator.dismiss(animated: true)
        XCTAssertEqual(coordinator.navigationController?.viewControllers.count, 1)
        XCTAssertNotEqual(coordinator.navigationController?.visibleViewController, childViewController)
        XCTAssertEqual(coordinator.navigationController?.visibleViewController, rootViewController)
        XCTAssertEqual(coordinator.presentedViewControllers.count, 0)
        XCTAssertEqual(coordinator.presentationStyles.count, 0)
    }

    func test_ViewController_presentationStyle_present() {
        let childViewController = MockViewController()
        childViewController.title = "Child 1"

        let rootViewController = UIViewController()
        let coordinator = Presentor(rootViewController: rootViewController)
        let window = UIWindow.init(frame: .zero)
        window.rootViewController = coordinator.rootViewController
        window.makeKeyAndVisible()

        XCTAssertNil(coordinator.navigationController)
        coordinator.show(viewController: childViewController, animated: false, presentationStyle: .present)
        XCTAssertEqual(childViewController.isBeingPresented, true)
        XCTAssertEqual(coordinator.rootViewController.presentedViewController, childViewController)
        XCTAssertEqual(childViewController.presentingViewController, rootViewController)
        XCTAssertEqual(childViewController.didMoveToParentCalled, true)
        XCTAssertEqual(childViewController.willMoveToParentCalled, true)
        childViewController.didMoveToParentCalled = false
        childViewController.willMoveToParentCalled = false
        childViewController.viewWillDisappear(true)
        coordinator.dismiss(animated: false)
        childViewController.viewWillDisappear(true)

    }

    func testPresentingViewController() {

        let viewController = MockViewController()
        viewController.title = "View Controller"

        let viewController1 = MockViewController()
        viewController1.title = "View Controller 1"

        let rootViewController = MockViewController()
        rootViewController.title = "Root View Controller"

        let presentor = Presentor(rootViewController: rootViewController)
        XCTAssertEqual(presentor.presentingViewController, rootViewController)

        presentor.show(viewController: viewController, animated: false, presentationStyle: .present)
        XCTAssertEqual(presentor.presentingViewController, viewController)

        presentor.show(viewController: viewController1, animated: false, presentationStyle: .present)
        XCTAssertEqual(presentor.presentingViewController, viewController1)

    }

    func testPushingViewController_Presentor_default_init() {

        let viewController = MockViewController()
        viewController.title = "View Controller"

        let viewController1 = MockViewController()
        viewController1.title = "View Controller 1"

        let rootViewController = MockViewController()
        rootViewController.title = "Root View Controller"

        let presentor = Presentor()
        XCTAssertNotNil(presentor.navigationController)
        XCTAssertNotNil(presentor.navigationController?.topViewController)
        XCTAssertEqual(presentor.navigationController?.viewControllers.count, 1)
        XCTAssertEqual(presentor.presentingViewController, presentor.navigationController?.topViewController)
        XCTAssertEqual(presentor.presentingViewController, presentor.navigationController?.viewControllers.first)

        presentor.show(viewController: viewController, animated: false, presentationStyle: .push)
        XCTAssertEqual(presentor.presentingViewController, viewController)

        presentor.show(viewController: viewController1, animated: false, presentationStyle: .push)
        XCTAssertEqual(presentor.presentingViewController, viewController1)

    }

    func testPushingViewController_Presentor_VC_rootViewController() {

        let viewController = MockViewController()
        viewController.title = "View Controller"

        let viewController1 = MockViewController()
        viewController1.title = "View Controller 1"

        let rootViewController = MockViewController()
        rootViewController.title = "Root View Controller"

        let presentor = Presentor(rootViewController: rootViewController)
        XCTAssertNil(presentor.navigationController)
        XCTAssertNil(presentor.navigationController?.topViewController)
        XCTAssertEqual(presentor.navigationController?.viewControllers.count, nil)
        XCTAssertEqual(presentor.presentingViewController, rootViewController)

        presentor.show(viewController: viewController, animated: false, presentationStyle: .present)
        XCTAssertEqual(presentor.presentingViewController, viewController)

        presentor.show(viewController: viewController1, animated: false, presentationStyle: .present)
        XCTAssertEqual(presentor.presentingViewController, viewController1)

    }

    func testPushingViewController_Presentor_Nav_rootViewController() {

        let viewController = MockViewController()
        viewController.title = "View Controller"

        let viewController1 = MockViewController()
        viewController1.title = "View Controller 1"

        let rootViewController = MockViewController()
        rootViewController.title = "Root View Controller"

        let navigationController = UINavigationController(rootViewController: rootViewController)

        let presentor = Presentor(rootViewController: navigationController)
        XCTAssertNotNil(presentor.navigationController)
        XCTAssertNotNil(presentor.navigationController?.topViewController)
        XCTAssertEqual(presentor.navigationController?.viewControllers.count, 1)
        XCTAssertEqual(presentor.presentingViewController, rootViewController)

        presentor.show(viewController: viewController, animated: false, presentationStyle: .push)
        XCTAssertEqual(presentor.presentingViewController, viewController)

        presentor.show(viewController: viewController1, animated: false, presentationStyle: .push)
        XCTAssertEqual(presentor.presentingViewController, viewController1)

    }

    /// MARK: Fatal Error Tests - Uncomment to check all thrown exceptions.

//    func test_Coordinator_asViewController_using_dismiss_and_presentationStyle_push() {
//        let childViewController = UIViewController()
//        childViewController.title = "Child 1"
//
//        let rootViewController = UIViewController()
//        let coordinator = Coordinator(rootViewController: rootViewController)
//
//        XCTAssertNil(coordinator.navigationController)
//        coordinator.show(viewController: childViewController, animated: false, presentationStyle: .push)
//    
//        coordinator.dismiss(animated: true)
//    }

//    func test_Pushing_viewcontroller_twice() {
//        let childViewController = UIViewController()
//        childViewController.title = "Child 1"
//
//        let rootViewController = UIViewController()
//        let navigationController = UINavigationController(rootViewController: rootViewController)
//        let coordinator = Coordinator(rootViewController: navigationController)
//
//        coordinator.show(viewController: childViewController, animated: false, presentationStyle: .push)
//        coordinator.show(viewController: childViewController, animated: false, presentationStyle: .push)
//
//        coordinator.dismiss(animated: true)
//    }

}
