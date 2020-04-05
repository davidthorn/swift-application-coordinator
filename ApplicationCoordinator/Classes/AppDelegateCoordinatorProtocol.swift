//
//  AppDelegateCoordinatorProtocol.swift
//  ApplicationCoordinator
//
//  Created by Thorn, David on 05.04.20.
//  Copyright © 2020 Thorn, David. All rights reserved.
//

import UIKit

public protocol AppDelegateCoordinatorProtocol {

    /// responsible for controlling which view controller is used for the windows rootViewController upon initial launch.

    /// How can you attach the root view controller to the window'?

    /// The windows root view controller.
    /// This can be a navigation controller also
    var rootViewController: UIViewController { get }

    var window: UIWindow? { get }

    func createWindow() -> UIWindow

}
