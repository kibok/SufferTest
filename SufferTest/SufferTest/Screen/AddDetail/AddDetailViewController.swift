//
//  AddDetailViewController.swift
//  SufferTest
//
//  Created by 朴 基馥 on 2018/03/19.
//  Copyright © 2018年 Fenrir Inc. All rights reserved.
//

import UIKit

class AddDetailViewController: UIViewController {
    
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var amountTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func touUpInsideInputButton(_ sender: Any) {
        let amount = Int(self.amountTextField.text ?? "0")
        DataManager.addDetail(detail: Detail(title: self.titleTextField.text ?? "", amount: amount!))
        HistoryFetcher.updateProject(data: ProjectAPI.makeProjectParameters()!)
        
        self.performSegue(withIdentifier: "backToTop", sender: nil)
    }
    
    func validattionCheck() {
        // validat
    }
    
}
