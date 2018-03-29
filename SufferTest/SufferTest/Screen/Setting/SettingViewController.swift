//
//  SettingViewController.swift
//  SufferTest
//
//  Created by 朴 基馥 on 2018/03/27.
//  Copyright © 2018年 Fenrir Inc. All rights reserved.
//

import UIKit

class SettingViewController: UIViewController {
    
    enum cellType {
        case password
        case qa
        case terms
        case license
        case delete
     
        var name: String {
            switch self {
            case .password:
                return "비번변경"
            case .qa:
                return "질문하기"
            case .terms:
                return "이용약관"
            case .license:
                return "License"
            case .delete:
                return "회원탈퇴"
            }
        }
    }

    @IBOutlet weak var tableView: UITableView!
    
    private let cellType: [[cellType]] = [[.password, .qa, .terms, .license  ], [.delete]]
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
}

extension SettingViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section == 0 ? 4 : 1
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "settingCell", for: indexPath)
        cell.textLabel?.text = self.cellType[indexPath.section][indexPath.row].name
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        switch self.cellType[indexPath.section][indexPath.row] {
        case .password:
            print("a")
        case .qa:
            print("b")
        case .terms:
            print("c")
        case .license:
            self.performSegue(withIdentifier: "toLicense", sender: nil)
        case .delete:
            print("e")
        }
    }
    
}
