//
//  MockPages.swift
//  ApplicationCoordinatorTests
//
//  Created by Thorn, David on 05.04.20.
//  Copyright © 2020 Thorn, David. All rights reserved.
//

import UIKit
import ApplicationCoordinator

struct HomePage: PageProtocol {

    var presentationStyle: PresentationStyle = .push

    func viewController(delegate: CoordinatorDelegateProtocol, request: URLRequest?) -> UIViewController {
        let controller = MockViewController()
        controller.coordinatingDelegate = delegate
        controller.view.backgroundColor = .green
        controller.title = "Home Page"
        return controller
    }
}

struct RedPage: PageProtocol {

    var presentationStyle: PresentationStyle = .push

    func viewController(delegate: CoordinatorDelegateProtocol, request: URLRequest?) -> UIViewController {
        let controller = RedViewController()
        controller.coordinatingDelegate = delegate
        controller.view.backgroundColor = .red
        return controller
    }

}

struct BluePage: PageProtocol {

    var presentationStyle: PresentationStyle = .push

    func viewController(delegate: CoordinatorDelegateProtocol, request: URLRequest?) -> UIViewController {
        let controller = MockViewController()
        controller.coordinatingDelegate = delegate
        controller.view.backgroundColor = .blue

        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
            let page = RedPage()
            delegate.show(page: page, request: nil, completion: { })
        }

        DispatchQueue.main.asyncAfter(deadline: .now() + 15) {
            delegate.dismiss(animated: true, completed: { })
        }
        return controller
    }

}

struct OrangePage: PageProtocol {

    var presentationStyle: PresentationStyle = .present

    func viewController(delegate: CoordinatorDelegateProtocol, request: URLRequest?) -> UIViewController {
        let controller = OrangeViewController()
        controller.coordinatingDelegate = delegate
        controller.view.backgroundColor = .orange
        return controller
    }

}
