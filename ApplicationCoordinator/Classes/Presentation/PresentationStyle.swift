//
//  PresentationStyle.swift
//  ApplicationCoordinator
//
//  Created by Thorn, David on 05.04.20.
//  Copyright © 2020 Thorn, David. All rights reserved.
//

import Foundation

public enum PresentationStyle: Equatable {

    /// The view controller will be pushed on to the navigation controllers stack of view controllers
    case push

    /// The view controller will be presented by the top view controller in the stack of presented view controllers.
    case present

    /// The view controllers modalPresentationStyle  will be set to overCurrentContext
    case overCurrentContext
}
