//
//  HistoryTableViewCell.swift
//  SufferTest
//
//  Created by 朴 基馥 on 2018/03/22.
//  Copyright © 2018年 Fenrir Inc. All rights reserved.
//

import UIKit
import FoldingCell

class HistoryTableViewCell: FoldingCell {

    override func awakeFromNib() {
        foregroundView.layer.cornerRadius = 10
        foregroundView.layer.masksToBounds = true
        super.awakeFromNib()
    }
    
    override func animationDuration(_ itemIndex: NSInteger, type _: FoldingCell.AnimationType) -> TimeInterval {
        let durations = [0.26, 0.2, 0.2]
        return durations[itemIndex]
    }
    
}
