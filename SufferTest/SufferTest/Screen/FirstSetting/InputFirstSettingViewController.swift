//
//  InputFirstSettingViewController.swift
//  SufferTest
//
//  Created by Kibok on 2018. 3. 17..
//  Copyright © 2018년 Fenrir Inc. All rights reserved.
//

import UIKit

class InputFirstSettingViewController: UIViewController {

    @IBOutlet weak var endDateTextField: UITextField!
    @IBOutlet weak var amountTextField: UITextField!
    
    // MARK: - LifeCycles
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboard()
    }
    
    // MARK: - Actions
    
    @IBAction func touchUpInsiteNextButton(_ sender: Any) {
        self.performSegue(withIdentifier: "toConfirmation", sender: nil)
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toConfirmation", let vc = segue.destination as? ConfirmationFirstSettingViewController {
            let period = Int(self.endDateTextField.text ?? "0")
            let endDate = Calendar.current.date(byAdding: .day, value: period!, to: Date())
            let amount = Int(self.amountTextField.text ?? "0")
            vc.viewModel = ConfirmationFirstSettingViewModel(endDate: endDate!, amount: amount!)
        }
    }
    
    // MARK: - Private methods
    
    private func validattionCheck() -> Bool {
        // 1. 형식
        // 2. 글자수
        
        
        
        return true
    }
    
    private func dateChecker() -> Bool {
        
        return true
    }
    
    
}
