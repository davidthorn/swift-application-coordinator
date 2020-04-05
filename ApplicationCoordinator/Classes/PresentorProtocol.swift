//
//  PresentorProtocol.swift
//  
//
//  Created by Thorn, David on 04.04.20.
//

import UIKit

public protocol PresentorProtocol {

    /// The top most view controller in the presented view controllers stack.
    /// If no view controllers have been presented and the root view controller is a navigation controller
    /// then the navigation controllers topViewController will be used.
    /// If the navigation controller was initiated without a root view controller, then the navigation controller will be used.
    var presentingViewController: UIViewController { get }

    /// The main view controller that wil be used to present / push / show all child view controllers
    /// If the show method intends to push view controllers then the root view controller requires to be a navigation controller.
    var rootViewController: UIViewController { get }

    /// Returns a navigation controller if the root view controller is a navigation controller.
    var navigationController: UINavigationController? { get }

    /// All view controllers that have been shown / presented / pushed by the show method.
    var presentedViewControllers: [UIViewController] { get }

    /// The presentation styles index is directly related to how the child view controller at this index was presented
    /// The presentation style will be removed when the child view controller is also removed.
    var presentationStyles: [PresentationStyle] { get }

    /// Method presents / pushs / the view controller based upon the presentation style provided.
    /// If the root view controller is not a navigation controller then this method will end in a fatal error.
    func show(viewController: UIViewController, animated: Bool, presentationStyle: PresentationStyle)

    /// The top view controller is removed from the child view controllers based upon its related presentation style.
    /// presentation style of push, will call the view controllers pop view controller method on its navigation controller.
    /// presentation style of present will call the dismiss on the view controller.
    /// presentation style of over current context will call the dismiss method on the view controller.
    func dismiss(animated: Bool)

}
