//
//  ProgressDialog.swift
//  SufferTest
//
//  Created by 朴 基馥 on 2018/03/29.
//  Copyright © 2018年 Fenrir Inc. All rights reserved.
//

import UIKit

class ProgressDialog {
    
    static let shared = ProgressDialog()
    private let activityIndicator = UIActivityIndicatorView()
    
    private func setProgressDialog() {
        remove()
        activityIndicator.hidesWhenStopped = true
        activityIndicator.activityIndicatorViewStyle = .gray
    }
    
    func show() {
        setProgressDialog()
        let delegate = UIApplication.shared.delegate as! AppDelegate
        let view = delegate.window!.rootViewController!.view!
        
        DispatchQueue.main.async {
            self.activityIndicator.center = view.center
            self.activityIndicator.startAnimating()
            view.addSubview(self.activityIndicator)
            UIApplication.shared.beginIgnoringInteractionEvents()
        }
    }
    
    func remove(){
        DispatchQueue.main.async {
            self.activityIndicator.stopAnimating()
            self.activityIndicator.removeFromSuperview()
            UIApplication.shared.endIgnoringInteractionEvents()
        }
    }
    
}
