//
//  ListTableViewCell.swift
//  SufferTest
//
//  Created by 朴 基馥 on 2018/03/08.
//  Copyright © 2018年 Fenrir Inc. All rights reserved.
//

import UIKit
import FoldingCell

class ListTableViewCell: FoldingCell {
    
    // Rotated View
    @IBOutlet weak var inputDateLabel: UILabel!
    @IBOutlet weak var amountLabel: UILabel!
    
    // Container View
    @IBOutlet weak var containerInputDateLabel: UILabel!
    @IBOutlet weak var containerAmountLabel: UILabel!
    @IBOutlet weak var containerTitleLabel: UILabel!
    
    override func awakeFromNib() {
        foregroundView.layer.cornerRadius = 10
        foregroundView.layer.masksToBounds = true
        super.awakeFromNib()
    }
    
    override func animationDuration(_ itemIndex: NSInteger, type _: FoldingCell.AnimationType) -> TimeInterval {
        let durations = [0.26, 0.2, 0.2]
        return durations[itemIndex]
    }
    
    func setupCell(_ detail: Detail) {
        self.inputDateLabel.text = detail.inputDate.string(format: "MM/dd")
        self.amountLabel.text = detail.amount.currencyFormat
        
        self.containerInputDateLabel.text = detail.inputDate.string(format: "MM/dd")
        self.containerAmountLabel.text = detail.amount.currencyFormat
        self.containerTitleLabel.text = detail.title
    }
    
}
