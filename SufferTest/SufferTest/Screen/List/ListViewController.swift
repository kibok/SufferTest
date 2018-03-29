//
//  ListViewController.swift
//  SufferTest
//
//  Created by 朴 基馥 on 2018/03/08.
//  Copyright © 2018年 Fenrir Inc. All rights reserved.
//

import UIKit
import FoldingCell

struct ListViewModel {
    let details: [Detail]
}

class ListViewController: UIViewController {
    
    let kCloseCellHeight: CGFloat = 60 + 30
    let kOpenCellHeight: CGFloat = 150 + 30
    let kRowsCount = 2
    var cellHeights: [CGFloat] = []
    
    var viewModel: ListViewModel!
    
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            self.tableView.estimatedRowHeight = kCloseCellHeight
            self.tableView.rowHeight = UITableViewAutomaticDimension
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let details = DataManager.shared.ongoingProject?.details {
            self.viewModel = ListViewModel(details: details)
        }
        cellHeights = Array(repeating: kCloseCellHeight, count: self.viewModel.details.count)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
//        let indexPath = IndexPath(row: 0, section: self.cellHeights.count - 1)
//        self.tableView.scrollToRow(at: indexPath, at: .top, animated: false)
    }
    
}


extension ListViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
        return self.viewModel.details.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard case let cell as ListTableViewCell = cell else {
            return
        }

        cell.backgroundColor = .clear

        if cellHeights[indexPath.row] == kCloseCellHeight {
            cell.unfold(false, animated: false, completion: nil)
        } else {
            cell.unfold(true, animated: false, completion: nil)
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ListCell", for: indexPath) as! ListTableViewCell
        let durations: [TimeInterval] = [0.1, 0.1, 0.1]
        cell.durationsForExpandedState = durations
        cell.durationsForCollapsedState = durations
        cell.setupCell(self.viewModel.details[indexPath.row])
        return cell
    }
    
    func tableView(_: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return cellHeights[indexPath.row]
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! FoldingCell
        if cell.isAnimating() {
            return
        }
        
        var duration = 0.0
        let cellIsCollapsed = cellHeights[indexPath.row] == kCloseCellHeight
        if cellIsCollapsed {
            cellHeights[indexPath.row] = kOpenCellHeight
            cell.unfold(true, animated: false, completion: nil)
            duration = 0.3
        } else {
            cellHeights[indexPath.row] = kCloseCellHeight
            cell.unfold(false, animated: false, completion: nil)
            duration = 0.3
        }
        
        UIView.animate(withDuration: duration, delay: 0, options: .curveEaseOut, animations: { () -> Void in
            tableView.beginUpdates()
            tableView.endUpdates()
        }, completion: nil)
    }
    
}
