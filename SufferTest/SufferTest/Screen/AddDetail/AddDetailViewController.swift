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
    }

    @IBAction func touUpInsideInputButton(_ sender: Any) {
        DataManager.addDetail(detail: Detail(inputDate: Date(), title: self.titleTextField.text ?? "", amount: Int(self.amountTextField.text ?? "") ?? 0))
        HistoryFetcher.updateProject(data: ProjectAPI.makeProjectParameters()!, completion: { error in
            if let error = error {
                self.handleFirestoreError(error)
            } else {
                self.performSegue(withIdentifier: "backToTop", sender: nil)
            }
        })
    }
    
    func validattionCheck() {
        // validat
    }
    
}
