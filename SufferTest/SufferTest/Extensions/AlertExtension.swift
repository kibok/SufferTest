//
//  AlertExtension.swift
//  SufferTest
//
//  Created by 朴 基馥 on 2018/03/26.
//  Copyright © 2018年 Fenrir Inc. All rights reserved.
//

import UIKit

// MARK: - UIAlertController

extension UIAlertController {
    
    @discardableResult func addAction(title: String, style: UIAlertActionStyle = .default, isEnabled: Bool = true, handler: ((UIAlertAction) -> Void)? = nil) -> UIAlertAction {
        let action = UIAlertAction(title: title, style: style, handler: handler)
        action.isEnabled = isEnabled
        addAction(action)
        return action
    }
    
}

typealias AlertActionHandler = ((UIAlertAction) -> Void)

enum AlertStyle {
    
    /// Only OK action
    case ok(AlertActionHandler?)
    
    /// OK action and cancel action
    case okCancel(AlertActionHandler?, AlertActionHandler?)
    
    /// Default action with custom title and cancel action
    case customCancel(String, AlertActionHandler?, AlertActionHandler?)
    
    /// Default action with custom title and cancel with custom title action
    case custom(String, String, AlertActionHandler?, AlertActionHandler?)
    
}

extension UIAlertController {
    
    convenience init(title: String? = nil, message: String? = nil, style: AlertStyle) {
        self.init(title: title, message: message, preferredStyle: .alert)
        switch style {
        case .ok(let handler):
            addAction(title: "OK", style: .default, handler: handler)
        case .okCancel(let defaultHandler, let cancelHandler):
            addAction(title: "OK", style: .default, handler: defaultHandler)
            addAction(title: "キャンセル", style: .cancel, handler: cancelHandler)
        case .customCancel(let title, let defaultHandler, let cancelHandler):
            addAction(title: title, style: .default, handler: defaultHandler)
            addAction(title: "キャンセル", style: .cancel, handler: cancelHandler)
        case .custom(let title, let cancelTitle, let defaultHandler, let cancelHandler):
            addAction(title: title, style: .default, handler: defaultHandler)
            addAction(title: cancelTitle, style: .cancel, handler: cancelHandler)
        }
    }
    
}

protocol SimpleAlertPresenter {
}

extension UIViewController: SimpleAlertPresenter {
}

extension SimpleAlertPresenter where Self: UIViewController {
    
    /// Only message
    func showAlert(_ message: String?) {
        let alert = UIAlertController(title: nil, message: message, style: .ok(nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    /// Only OK action
    func showAlert(title: String? = nil, message: String? = nil, defaultHandler: AlertActionHandler? = nil) {
        let alert = UIAlertController(title: title, message: message, style: .ok(defaultHandler))
        self.present(alert, animated: true, completion: nil)
    }
    
    /// Customize the default action's title
    func showAlert(title: String? = nil,
                   message: String? = nil,
                   defaultActionTitle: String,
                   defaultHandler: AlertActionHandler? = nil) {
        let alert = UIAlertController(title: title, message: message, style: .customCancel(defaultActionTitle, defaultHandler, nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    /// Customize the default action's title and cancel title
    func showAlert(title: String? = nil,
                   message: String? = nil,
                   defaultActionTitle: String,
                   cancelActionTitle: String,
                   defaultHandler: AlertActionHandler? = nil,
                   cancelHandler: AlertActionHandler? = nil) {
        let alert = UIAlertController(title: title, message: message, style: .custom(defaultActionTitle, cancelActionTitle, defaultHandler, cancelHandler))
        self.present(alert, animated: true, completion: nil)
    }
    
}

