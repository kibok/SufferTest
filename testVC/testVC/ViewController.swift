//
//  ViewController.swift
//  testVC
//
//  Created by 朴 基馥 on 2018/03/30.
//  Copyright © 2018年 Fenrir Inc. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    @IBAction func testButton(_ sender: Any) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            UIView.transition(with: self.view, duration: 1, options: .transitionCrossDissolve, animations: {
                self.view.backgroundColor = UIColor(patternImage: UIImage(named: "bg")!)
            })
        }
        
//        UIView.transition(with: (self.navigationController?.navigationBar)!, duration: 1, options: .transitionCrossDissolve, animations: {
//            self.navigationController?.navigationBar.setBackgroundImage(UIImage(named: "bg")!, for: .default)
//        })
    }
    
    @IBAction func backToHome(segue: UIStoryboardSegue) {
        
//        UIView.transition(with: self.view, duration: 3, options: .transitionCrossDissolve, animations: {
//        }, completion: { _ in
//            self.view.backgroundColor = UIColor(patternImage: UIImage(named: "bg")!)
//        })
//
//        UIView.transition(with: (self.navigationController?.navigationBar)!, duration: 3, options: .transitionCrossDissolve, animations: {
//            self.navigationController?.navigationBar.setBackgroundImage(UIImage(named: "bg")!, for: .default)
//        })
        
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            UIView.transition(with: self.view, duration: 1, options: .transitionCrossDissolve, animations: {
                self.view.backgroundColor = UIColor(patternImage: UIImage(named: "bg")!)
            })
        }
        
        UIView.transition(with: (self.navigationController?.navigationBar)!, duration: 1, options: .transitionCrossDissolve, animations: {
            self.navigationController?.navigationBar.setBackgroundImage(UIImage(named: "bg")!, for: .default)
        })
        
    }
}

