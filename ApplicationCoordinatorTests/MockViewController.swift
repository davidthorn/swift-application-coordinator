//
//  MockViewController.swift
//  ApplicationCoordinatorTests
//
//  Created by Thorn, David on 04.04.20.
//  Copyright © 2020 Thorn, David. All rights reserved.
//

import UIKit

class MockViewController: UIViewController {

    var viewDidLoadCalled: Bool = false
    override func viewDidLoad() {
        super.viewDidLoad()
        viewDidLoadCalled = true
    }

    var willMoveToParentCalled: Bool = false
    override func willMove(toParent parent: UIViewController?) {
        super.willMove(toParent: parent)
        willMoveToParentCalled = true
    }

    var didMoveToParentCalled: Bool = false
    override func didMove(toParent parent: UIViewController?) {
        super.didMove(toParent: parent)
        didMoveToParentCalled = true
    }

    var viewWillDisappearCalled: Bool = false
    var isBeingDismissedSet: Bool = false
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        viewWillDisappearCalled = true
        isBeingDismissedSet = isBeingDismissed
    }

    var viewWillAppearCalled: Bool = false
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewWillAppearCalled = true
    }

    override func dismiss(animated flag: Bool, completion: (() -> Void)? = nil) {
        super.dismiss(animated: flag) {
            completion?()
        }
    }
}
