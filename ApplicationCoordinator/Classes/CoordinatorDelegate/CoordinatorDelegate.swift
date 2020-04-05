//
//  CoordinatorDelegate.swift
//  ApplicationCoordinator
//
//  Created by Thorn, David on 05.04.20.
//  Copyright © 2020 Thorn, David. All rights reserved.
//

import Foundation

public final class CoordinatorDelegate: CoordinatorDelegateProtocol {

    public var currentPage: PageProtocol

    public var parentCoordinator: CoordinatorDelegateProtocol?

    public var presentor: PresentorProtocol?

    public init(page: PageProtocol,
                presentor: PresentorProtocol? = nil,
                coordinatorDelegate: CoordinatorDelegateProtocol? = nil) {

        self.presentor = presentor
        self.parentCoordinator = coordinatorDelegate
        currentPage = page
    }

    public func setPresentor(presentor: PresentorProtocol) {
        self.presentor = presentor
    }

    public func dismiss(animated: Bool, completed: @escaping () -> Void) {

        guard let presentor = presentor else {
            return assertionFailure("All coordinator delegates require to have a presentor")
        }

        if presentor.presentedViewControllers.isEmpty {
            self.presentor = nil
            parentCoordinator?.dismiss(animated: animated, completed: { })
        } else {
            presentor.dismiss(animated: animated)
        }

    }

    public func show(page: PageProtocol, request: URLRequest? = nil, completion: @escaping () -> Void) {

        let coordinator = CoordinatorDelegate(page: page)
        coordinator.parentCoordinator = self
        
        let viewController = page.viewController(delegate: coordinator, request: request)
        (viewController as? Coordinating)?.coordinatingDelegate = coordinator
        
        switch page.presentationStyle {
        case .push:
            let childPresentor = Presentor(rootViewController: viewController)
            coordinator.setPresentor(presentor: childPresentor)
            presentor?.show(viewController: viewController, animated: true, presentationStyle: .push)
        case .overCurrentContext, .present:
            let navigationController = Presentor.PresentorNavigationController(rootViewController: viewController)
            let childPresentor = Presentor(rootViewController: navigationController)
            coordinator.setPresentor(presentor: childPresentor)
            presentor?.show(viewController: navigationController,
                            animated: true,
                            presentationStyle: page.presentationStyle)
        }

    }

    deinit {
        debugPrint("DEINIT CoordinatorDelegate")
    }

}
