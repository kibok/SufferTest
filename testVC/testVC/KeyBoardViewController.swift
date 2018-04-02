//
//  KeyBoardViewController.swift
//  testVC
//
//  Created by 朴 基馥 on 2018/04/02.
//  Copyright © 2018年 Fenrir Inc. All rights reserved.
//

import UIKit

class KeyBoardViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var inputLabel: UILabel!
    
    var inputedAmount: String = ""
    var array: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.inputLabel.text = self.inputedAmount
    }
    
    @IBAction func input1(_ sender: Any) {
        self.inputedAmount.append("1")
        self.inputLabel.text = self.inputedAmount
    }
    
    @IBAction func endInput(_ sender: Any) {
        self.tableView.beginUpdates()
        self.array.append(self.inputedAmount)
        self.inputedAmount = ""
        self.tableView.insertRows(at: [IndexPath(row: self.array.count - 1, section: 0)], with: .automatic)
        self.tableView.endUpdates()
    }
    
    @IBAction func editTableView(_ sender: Any) {
        self.tableView.setEditing(!self.tableView.isEditing, animated: true)
    }
    
}


extension KeyBoardViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
        return self.array.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Details", for: indexPath)
        cell.textLabel?.text = self.array[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            self.array.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
    
}

