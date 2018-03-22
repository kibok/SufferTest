//
//  LoginViewController.swift
//  SufferTest
//
//  Created by Kibok on 2018. 3. 12..
//  Copyright © 2018년 Fenrir Inc. All rights reserved.
//

import UIKit
import Firebase

protocol LoginViewControllerDelegate{
    func didFinishLogin()
}

class LoginViewController: UIViewController {

    @IBOutlet var idTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!
    
    var handle: AuthStateDidChangeListenerHandle?
    var delegate: LoginViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.handle = Auth.auth().addStateDidChangeListener { (auth, user) in
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        guard let handle = self.handle else {
            return
        }
        Auth.auth().removeStateDidChangeListener(handle)
    }
    
    // unwind segue
    
    @IBAction func backFromFirstSetting(segue:UIStoryboardSegue) {
        self.delegate?.didFinishLogin()
    }
    
    // action
    
    @IBAction func touchUpInsideLoginButton(_ sender: Any) {
        let id = self.idTextField.text ?? ""
        let pass = self.passwordTextField.text ?? ""
        AuthFetcher.login(email: id, password: pass, completion: { error in
            if let error = error {
                // add error handling
                print(error as NSError)
            } else {
                print("success login")
                HistoryFetcher.readProject(completion: { error in
                    if DataManager.shared.ongoingProject == nil {
                        self.performSegue(withIdentifier: "toFirstSetting", sender: nil)
                    } else {
                        self.delegate?.didFinishLogin()
                    }
                })
            }
        })
    }
    
    @IBAction func touchUpInsideSignupButton(_ sender: Any) {
        let id = self.idTextField.text ?? ""
        let pass = self.passwordTextField.text ?? ""
        AuthFetcher.signup(email: id, password: pass, completion: { error in
            if let error = error {
                print(error.localizedDescription)
            } else {
                print("success signup")
            }
        })
    }
    
    @IBAction func touchUpInsideFindPasswordButton(_ sender: Any) {
    }
    
}
