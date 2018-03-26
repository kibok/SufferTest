//
//  UIKitExtensions.swift
//  SufferTest
//
//  Created by 朴 基馥 on 2018/03/26.
//  Copyright © 2018年 Fenrir Inc. All rights reserved.
//

import UIKit

extension UIViewController {
    func hideKeyboard() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
