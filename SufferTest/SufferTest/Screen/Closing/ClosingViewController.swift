//
//  ClosingViewController.swift
//  SufferTest
//
//  Created by 朴 基馥 on 2018/04/04.
//  Copyright © 2018年 Fenrir Inc. All rights reserved.
//

import UIKit

struct ClosingViewModel {
    let isClosing: Bool
}

class ClosingViewController: UIViewController {
    
    var viewModel: ClosingViewModel?

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? InputFirstSettingViewController {
            vc.viewModel = InputFirstSettingViewModel(isClosing: true)
        }
    }
    
    @IBAction func touchUpInsideNextButton(_ sender: Any) {        
        self.performSegue(withIdentifier: "toInputFirstSetting", sender: nil)
    }
    
}
