//
//  CoordinatorDelegateTests.swift
//  ApplicationCoordinatorTests
//
//  Created by Thorn, David on 05.04.20.
//  Copyright © 2020 Thorn, David. All rights reserved.
//

import XCTest
@testable import ApplicationCoordinator

class CoordinatorDelegateTests: XCTestCase {

    func test1() {

        let homePage = HomePage()
        let coordinatorDelegate = CoordinatorDelegate(page: homePage)
        let homeController = homePage.viewController(delegate: coordinatorDelegate, request: nil)
        let navigationController = Presentor.PresentorNavigationController(rootViewController: homeController)
        let presentor = Presentor(rootViewController: navigationController)
        coordinatorDelegate.setPresentor(presentor: presentor)

        let appDelegateCoordinator = AppDelegateCoordinator(rootViewController: navigationController)
        let window = appDelegateCoordinator.createWindow()

    }
}
