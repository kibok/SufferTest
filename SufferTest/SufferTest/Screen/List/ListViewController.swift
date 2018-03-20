//
//  ListViewController.swift
//  SufferTest
//
//  Created by 朴 基馥 on 2018/03/08.
//  Copyright © 2018年 Fenrir Inc. All rights reserved.
//

import UIKit
import FoldingCell

class ListViewController: UIViewController {
    
    let kCloseCellHeight: CGFloat = 60 + 30
    let kOpenCellHeight: CGFloat = 180 + 30
    let kRowsCount = 3
    var cellHeights: [[CGFloat]] = []
    
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            self.tableView.estimatedRowHeight = kCloseCellHeight
            self.tableView.rowHeight = UITableViewAutomaticDimension
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        cellHeights = [Array(repeating: kCloseCellHeight, count: kRowsCount),
                       Array(repeating: kCloseCellHeight, count: kRowsCount),
                       Array(repeating: kCloseCellHeight, count: kRowsCount),
                       Array(repeating: kCloseCellHeight, count: kRowsCount),
                       Array(repeating: kCloseCellHeight, count: kRowsCount)]
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
//        let indexPath = IndexPath(row: 0, section: self.cellHeights.count - 1)
//        self.tableView.scrollToRow(at: indexPath, at: .top, animated: false)
    }
    
}


extension ListViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
        return 3
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 5
    }
    
    func tableView(_: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard case let cell as ListTableViewCell = cell else {
            return
        }

        cell.backgroundColor = .clear

        if cellHeights[indexPath.section][indexPath.row] == kCloseCellHeight {
            cell.unfold(false, animated: false, completion: nil)
        } else {
            cell.unfold(true, animated: false, completion: nil)
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ListCell", for: indexPath) as! FoldingCell
        let durations: [TimeInterval] = [0.26, 0.2, 0.2]
        cell.durationsForExpandedState = durations
        cell.durationsForCollapsedState = durations
        return cell
    }
    
    func tableView(_: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return cellHeights[indexPath.section][indexPath.row]
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! FoldingCell
        if cell.isAnimating() {
            return
        }
        
        var duration = 0.0
        let cellIsCollapsed = cellHeights[indexPath.section][indexPath.row] == kCloseCellHeight
        if cellIsCollapsed {
            cellHeights[indexPath.section][indexPath.row] = kOpenCellHeight
            cell.unfold(true, animated: true, completion: nil)
            duration = 0.5
        } else {
            cellHeights[indexPath.section][indexPath.row] = kCloseCellHeight
            cell.unfold(false, animated: true, completion: nil)
            duration = 0.8
        }
        
        UIView.animate(withDuration: duration, delay: 0, options: .curveEaseOut, animations: { () -> Void in
            tableView.beginUpdates()
            tableView.endUpdates()
        }, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "2018 3 ~ 2018 4"
    }
    
}
