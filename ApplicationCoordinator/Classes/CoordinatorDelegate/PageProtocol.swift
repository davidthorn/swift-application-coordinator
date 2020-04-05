//
//  PageProtocol.swift
//  ApplicationCoordinator
//
//  Created by Thorn, David on 05.04.20.
//  Copyright © 2020 Thorn, David. All rights reserved.
//

import UIKit

public protocol PageProtocol {

    func viewController(delegate: CoordinatorDelegateProtocol, request: URLRequest?) -> UIViewController

    var presentationStyle: PresentationStyle { get }
}
