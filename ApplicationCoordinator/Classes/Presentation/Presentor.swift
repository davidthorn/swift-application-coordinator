//
//  Presentor.swift
//  ApplicationCoordinator
//
//  Created by Thorn, David on 04.04.20.
//  Copyright © 2020 Thorn, David. All rights reserved.
//

import UIKit

open class Presentor: PresentorProtocol {

    public final class PresentorNavigationController: UINavigationController {

        override public func viewDidLoad() {
            super.viewDidLoad()
            view.backgroundColor = .white
        }

    }

    public final class PresentorDefaultViewController: UIViewController {
        override public func viewDidLoad() {
            super.viewDidLoad()
            title = "Default"
            view.backgroundColor = .white
        }
    }

    public var rootViewController: UIViewController

    public var presentedViewControllers: [UIViewController] = []

    public var presentationStyles: [PresentationStyle] = []

    public var navigationController: UINavigationController? {
        rootViewController as? UINavigationController ?? rootViewController.navigationController
    }

    public var presentingViewController: UIViewController {
        if let navigationController = navigationController, presentedViewControllers.isEmpty {
            return navigationController.topViewController ?? rootViewController
        }

        return presentedViewControllers.last ?? rootViewController
    }

    public init(rootViewController: UIViewController) {
        self.rootViewController = rootViewController
    }

    public convenience init() {
        let defaultViewController = PresentorDefaultViewController()
        self.init(rootViewController: PresentorNavigationController(rootViewController: defaultViewController))
    }

    public func show(viewController: UIViewController, animated: Bool, presentationStyle: PresentationStyle) {

        if navigationController == nil, presentationStyle == .push {
            assertionFailure("A navigation controller is required as root view controller to presented using push.")
        }

        if presentedViewControllers.contains(where: { $0 == viewController }),
            presentationStyle == .push {
            assertionFailure("The view controller has already been pushed and cannot be pushed again")
        }

        presentedViewControllers.append(viewController)
        presentationStyles.append(presentationStyle)

        switch presentationStyle {
        case .overCurrentContext:
            viewController.modalPresentationStyle = .overCurrentContext
            viewController.willMove(toParent: rootViewController)
            rootViewController.present(viewController, animated: animated)
            viewController.didMove(toParent: rootViewController)
        case .present:
            viewController.willMove(toParent: rootViewController)
            rootViewController.present(viewController, animated: animated)
            viewController.didMove(toParent: rootViewController)
        case .push:
            var viewControllers = navigationController?.viewControllers ?? []
            viewControllers.append(viewController)
            viewController.willMove(toParent: navigationController)
            navigationController?.pushViewController(viewController, animated: animated)
            navigationController?.setViewControllers(viewControllers, animated: animated)
            viewController.didMove(toParent: navigationController)
        }
    }

    public func dismiss(animated: Bool, completion: VoidCompletion? = nil) {
        guard let viewController = presentedViewControllers.last, let presentationStyle = presentationStyles.last else {
            return assertionFailure("There are no child view controllers that require to be dismissed")
        }

        presentedViewControllers.removeAll(where: { $0 == viewController })
        presentationStyles.removeAll(where: { $0 == presentationStyle })

        switch presentationStyle {
        case .overCurrentContext, .present:
            viewController.willMove(toParent: nil)
            presentingViewController.viewWillAppear(animated)
            viewController.dismiss(animated: false)
            viewController.didMove(toParent: nil)
            presentingViewController.viewDidAppear(animated)
        case .push:

            if let navigationController = navigationController {
                assert(navigationController.viewControllers.contains(where: { $0 == viewController }))
            } else {
                assertionFailure("The navigation controller must not be nil when the presentation style is push")
            }

            navigationController?.viewControllers.removeAll(where: { $0 == viewController })
            let viewControllers =  navigationController?.viewControllers ?? []
            viewController.navigationController?.popViewController(animated: animated)
            navigationController?.setViewControllers(viewControllers, animated: animated)
        }

        completion?()
    }

    deinit {
        debugPrint("Presentor deinit")
    }
}

