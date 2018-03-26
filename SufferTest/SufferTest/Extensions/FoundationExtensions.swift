//
//  DateExtension.swift
//  SufferTest
//
//  Created by 朴 基馥 on 2018/03/19.
//  Copyright © 2018年 Fenrir Inc. All rights reserved.
//

import Foundation

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
