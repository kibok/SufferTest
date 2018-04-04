//
//  InputFirstSettingViewController.swift
//  SufferTest
//
//  Created by Kibok on 2018. 3. 17..
//  Copyright © 2018년 Fenrir Inc. All rights reserved.
//

import UIKit

struct InputFirstSettingViewModel {
    let isClosing: Bool
}

class InputFirstSettingViewController: UIViewController {

    @IBOutlet weak var periodTextField: UITextField!
    @IBOutlet weak var amountTextField: UITextField!
    
    var viewModel: InputFirstSettingViewModel!
    
    // MARK: - LifeCycles
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboard()
    }
    
    // MARK: - Actions
    
    @IBAction func touchUpInsiteNextButton(_ sender: Any) {
        let alertTilte = "입력실패"
        if let invalideDate = self.periodValidationChecker() {
            self.showAlert(title: alertTilte, message: invalideDate)
            return
        }
        
        if let invalidAmount = self.amountValidationChecker() {
            self.showAlert(title: alertTilte, message: invalidAmount)
            return
        }
        
        self.performSegue(withIdentifier: "toConfirmation", sender: nil)
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toConfirmation", let vc = segue.destination as? ConfirmationFirstSettingViewController,
            let period = self.periodTextField.text?.int,
            let amount = self.amountTextField.text?.int,
            let endDate = Calendar.current.date(byAdding: .day, value: period, to: Date()) {
            vc.viewModel = ConfirmationFirstSettingViewModel(endDate: endDate, amount: amount, isClosing: self.viewModel.isClosing)
        }
    }
    
    // MARK: - Private methods
    
    // Validation Rule
    // 날짜: 설정가능 날짜는 1~31, 기본값은 그 달의 날짜수
    // 금액: 0 이상

    private func periodValidationChecker() -> String? {
        guard let text = self.periodTextField.text else {
            return "실패"
        }
        
        if text == "" {
            return "기간을 입력해주세요"
        }
        
        if let int = text.int, int <= 0 || int > 31 {
            return "올바른 기간을 입력해주세요"
        }
        
        return nil
    }
    
    private func amountValidationChecker() -> String? {
        guard let text = self.amountTextField.text else {
            return "실패"
        }
        
        if text == "" {
            return "금액을 입력해주세요"
        }
        
        if let int = text.int, int <= 0 {
            return "올바른 금액을 입력해주세요"
        }
        return nil
    }
    
}
