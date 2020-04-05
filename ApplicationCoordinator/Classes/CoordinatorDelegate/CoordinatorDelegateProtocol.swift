//
//  CoordinatorDelegateProtocol.swift
//  ApplicationCoordinator
//
//  Created by Thorn, David on 05.04.20.
//  Copyright © 2020 Thorn, David. All rights reserved.
//

import Foundation

public protocol CoordinatorDelegateProtocol: class {

    var presentor: PresentorProtocol? { get }

    var parentCoordinator: CoordinatorDelegateProtocol? { get }

    var currentPage: PageProtocol { get }

    func setPresentor(presentor: PresentorProtocol)

    /// Presents the pages view controller using it presentaiton style.
    func show(page: PageProtocol, request: URLRequest?, completion: @escaping () -> Void)

    /// Dismisses the currently displayed pages view controller from view.
    func dismiss(animated: Bool, completed: @escaping () -> Void)
}
