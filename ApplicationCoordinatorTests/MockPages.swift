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

//        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
//            let page = OrangePage()
//            delegate.show(page: page, request: nil, completion: { })
//        }
        return controller
    }

}

struct BluePage: PageProtocol {

    var presentationStyle: PresentationStyle = .push

    func viewController(delegate: CoordinatorDelegateProtocol, request: URLRequest?) -> UIViewController {
        let controller = MockViewController()
        controller.coordinatingDelegate = delegate
        controller.view.backgroundColor = .blue

        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            let page = RedPage()
            delegate.show(page: page, request: nil, completion: { })
        }

        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            delegate.dismiss(animated: true) {
                controller.viewWillAppear(true)
            }
        }

        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
            delegate.dismiss(animated: true, completion: { })
        }

        DispatchQueue.main.asyncAfter(deadline: .now() + 7) {
            let page = OrangePage()
            delegate.show(page: page, request: nil, completion: { })
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

        DispatchQueue.main.asyncAfter(deadline: .now() + 7) {
            delegate.dismiss(animated: true, completion: { })
        }
        return controller
    }

}
