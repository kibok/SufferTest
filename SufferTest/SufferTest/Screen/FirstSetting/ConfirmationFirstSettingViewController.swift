//
//  ConfirmationFirstSettingViewController.swift
//  SufferTest
//
//  Created by Kibok on 2018. 3. 17..
//  Copyright © 2018년 Fenrir Inc. All rights reserved.
//

import UIKit

struct ConfirmationFirstSettingViewModel {
    let endDate: Date
    let amount: Int
}

class ConfirmationFirstSettingViewController: UIViewController {
    
    @IBOutlet weak var periodLabel: UILabel!
    @IBOutlet weak var amountLabel: UILabel!
    
    var viewModel: ConfirmationFirstSettingViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.periodLabel.text = viewModel.endDate.string(format: "yyyy/MM/dd")
        self.amountLabel.text = viewModel.amount.currencyFormat
    }
    
    @IBAction func touchUpInsideCompleteButton(_ sender: Any) {
        DataManager.updateongoing(project: Project(state: .ongoing, endDate: viewModel.endDate, startAmout: viewModel.amount))
        HistoryFetcher.startProject(data: ProjectAPI.makeUserHistoryParameters())
        self.performSegue(withIdentifier: "backToLogin", sender: nil)
    }

}
