//
//  AppDelegateCoordinator.swift
//  ApplicationCoordinator
//
//  Created by Thorn, David on 04.04.20.
//  Copyright © 2020 Thorn, David. All rights reserved.
//

import UIKit

public class AppDelegateCoordinator: AppDelegateCoordinatorProtocol {

    public var rootViewController: UIViewController

    public var window: UIWindow?

    public init(rootViewController: UIViewController) {
        self.rootViewController = rootViewController
    }

    public func createWindow() -> UIWindow {

        guard let window = window else {
            let window = UIWindow(frame: UIScreen.main.bounds)
            window.rootViewController = rootViewController
            window.makeKeyAndVisible()
            self.window = window
            return createWindow()
        }

        return window
    }

}
