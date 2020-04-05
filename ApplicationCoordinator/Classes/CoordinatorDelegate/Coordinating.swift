//
//  Coordinating.swift
//  ApplicationCoordinator
//
//  Created by Thorn, David on 05.04.20.
//  Copyright © 2020 Thorn, David. All rights reserved.
//

import Foundation

public protocol Coordinating: class {
    var coordinatingDelegate: CoordinatorDelegateProtocol? { get set }
}
