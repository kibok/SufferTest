//
//  AddDetailViewController.swift
//  SufferTest
//
//  Created by 朴 基馥 on 2018/03/19.
//  Copyright © 2018年 Fenrir Inc. All rights reserved.
//

import UIKit

class AddDetailViewController: UIViewController, FirestoreErrorHandling {
    
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var amountTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboard()
    }
    
    @IBAction func touUpInsideInputButton(_ sender: Any) {
        let alertTilte = "입력실패"
        if let invalidetitle = self.titleValidationChecker() {
            self.showAlert(title: alertTilte, message: invalidetitle)
            return
        }
        
        if let invalidAmount = self.amountValidationChecker() {
            self.showAlert(title: alertTilte, message: invalidAmount)
            return
        }
        
        self.addDetailReguest()
    }
    
    // MARK: - Private methods
    
    private func addDetailReguest() {
        DataManager.addDetail(detail: Detail(inputDate: Date(), title: self.titleTextField.text ?? "", amount: self.amountTextField.text?.int ?? 0))
        HistoryFetcher.updateProject(data: ProjectAPI.makeProjectParameters()!, completion: { error in
            if let error = error {
                self.handleFirestoreError(error)
            } else {
                self.performSegue(withIdentifier: "backToTop", sender: nil)
            }
        })
    }
    
    // Validation Rule
    // 날짜: 설정가능 날짜는 1~31, 기본값은 그 달의 날짜수
    // 금액: 0 이상
    
    private func titleValidationChecker() -> String? {
        guard let text = self.titleTextField.text else {
            return "실패"
        }
        
        if text == "" {
            return "무엇에 썼는지 입력해주세요"
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
