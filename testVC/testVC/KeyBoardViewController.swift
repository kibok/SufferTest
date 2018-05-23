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
    @IBOutlet weak var editButton: UIButton!
    
    private var calculator = Calculator()
    
    typealias CellData = (String, String)
    
    var cellDataArray: [CellData] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.inputLabel.text = "0"
    }
    
    @IBAction func inputNumber(_ sender: UIButton) {
        if let label = sender.titleLabel?.text {
            do {
                try calculator.input(label)
                inputLabel.text = calculator.displayValue
            } catch let error {
                print("\(error.localizedDescription)")
            }
        }
    }
    
    @IBAction func calculationTapped(_ sender: UIButton) {
        if let label = sender.titleLabel?.text {
            do {
                try calculator.input(label)
                inputLabel.text = calculator.displayValue
            } catch let error {
                print("\(error.localizedDescription)")
            }
        }
    }
    
    @IBAction func equalsTapped(_ sender: UIButton) {
        if let label = sender.titleLabel?.text {
            
            do {
                try calculator.input(label)
                inputLabel.text = calculator.displayValue
            } catch let error {
                print("\(error.localizedDescription)")
            }
        }
    }
    
    @IBAction func endInput(_ sender: Any) {
        self.tableView.beginUpdates()
        self.cellDataArray.append(("ブラブラブラ", self.inputLabel.text!))
        self.calculator.clear()
        self.inputLabel.text = "0"
        self.tableView.insertRows(at: [IndexPath(row: self.cellDataArray.count - 1, section: 0)], with: .automatic)
        self.tableView.endUpdates()
    }
    
    @IBAction func editTableView(_ sender: Any) {
        self.tableView.setEditing(!self.tableView.isEditing, animated: true)
        
        switch self.tableView.isEditing {
        case true:
            self.editButton.setTitle("Cancle", for: .normal)
        case false:
            self.editButton.setTitle("Edit", for: .normal)
        }

    }
    
}

extension KeyBoardViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
        return self.cellDataArray.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Details", for: indexPath) as! KeyBoardTableViewCell
        
        cell.title.text = self.cellDataArray[indexPath.row].0
        cell.detail.text = self.cellDataArray[indexPath.row].1
//        cell.separatorInset.left = 50
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            self.cellDataArray.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
    
}


extension Int {
    
    var currencyFormat: String {
        let numberFormatter = NumberFormatter()
        numberFormatter.locale = Locale(identifier: "ja_JP")
        numberFormatter.numberStyle = .currency
        return numberFormatter.string(from: NSNumber(value:self))!
    }
    
}

extension Date {
    
    func string(format: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        formatter.locale = Locale(identifier: "ja_JP")
        return formatter.string(from: self)
    }
    
}

extension String {
    
    var int: Int? {
        return Int(self)
    }
    
}

