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
        
        func showErrorAlert(error: validateError?) {
            if let error = error {
                let alertTilte = "입력실패"
                self.showAlert(title: alertTilte, message: error.message)
            }
        }
        
        if let error = self.validateTitle() {
            showErrorAlert(error: error)
            return
        }
        
        if let error = self.validateAmount() {
            showErrorAlert(error: error)
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
        
        //        HistoryFetcher.updateDetail(Detail(inputDate: Date(), title: self.titleTextField.text ?? "", amount: self.amountTextField.text?.int ?? 0)) { (error) in
        //            print("you did it!")
        //        }
    }
    
}

// AddDetailViewController Validator
extension AddDetailViewController {
    
    enum validateError {
        case loadFailure
        case noTitle
        case noAmount
        case lackOfAmount
        
        var message: String {
            switch self {
            case .loadFailure:
                return "처리 실패"
            case .noAmount:
                return "금액을 입력해주세요"
            case .noTitle:
                return "무엇에 썼는지 입력해주세요"
            case .lackOfAmount:
                return "정확한 금액을 입력해주세요"
            }
        }
    }
    
    private func validateTitle() -> validateError? {
        guard let text = self.titleTextField.text else {
            return .loadFailure
        }
        if text == "" {
            return .noTitle
        }
        return nil
    }
    
    private func validateAmount() -> validateError? {
        guard let text = self.amountTextField.text else {
            return .loadFailure
        }
        if text == "" {
            return .noAmount
        }
        if let int = text.int, int <= 0 {
            return .lackOfAmount
        }
        return nil
    }
    
}
