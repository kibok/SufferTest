//
//  AutoRootController.swift
//  SufferTest
//
//  Created by Kibok on 2018. 3. 12..
//  Copyright © 2018년 Fenrir Inc. All rights reserved.
//

import UIKit

class AutoRootController: UIViewController{
    
    @IBOutlet weak var containerView: UIView!
    
    private var loginViewController: LoginViewController?
    private var topViewController: TopViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.loginViewController = self.storyboard?.instantiateViewController(withIdentifier: "Login") as? LoginViewController
        self.loginViewController?.view.translatesAutoresizingMaskIntoConstraints = false
        self.loginViewController?.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // 자동 로그인 처리
        self.addChildViewController(self.loginViewController!)
        self.addSubview(subView: self.loginViewController!.view, toView: self.containerView)
    }
    
    // MARK: - Private methods
    
    private func cycleFromViewController(oldViewController: UIViewController, toViewController newViewController: UIViewController) {
        oldViewController.willMove(toParentViewController: nil)
        self.addChildViewController(newViewController)
        self.addSubview(subView: newViewController.view, toView:self.containerView!)
        newViewController.view.alpha = 0
        newViewController.view.layoutIfNeeded()
        UIView.animate(withDuration: 0.5, animations: {
            newViewController.view.alpha = 1
            oldViewController.view.alpha = 0
        },
                       completion: { finished in
                        oldViewController.view.removeFromSuperview()
                        oldViewController.removeFromParentViewController()
                        newViewController.didMove(toParentViewController: self)
        })
    }
    
    private func addSubview(subView:UIView, toView parentView:UIView) {
        parentView.addSubview(subView)
        var viewBindingsDict = [String: AnyObject]()
        viewBindingsDict["subView"] = subView
        parentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[subView]|",
                                                                 options: [], metrics: nil, views: viewBindingsDict))
        parentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[subView]|",
                                                                 options: [], metrics: nil, views: viewBindingsDict))
    }
    
}

// LoginViewControllerDelegate, TopViewControllerDelegate

extension AutoRootController: LoginViewControllerDelegate, TopViewControllerDelegate {
    
    func didFinishLogin() {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "Top") as! TopViewController
        vc.delegate = self
        self.topViewController = vc
        self.cycleFromViewController(oldViewController: self.loginViewController!, toViewController: self.topViewController!)
    }
    
    func didFinishLogout() {
        self.cycleFromViewController(oldViewController: self.topViewController!, toViewController: self.loginViewController!)
    }
    
}

