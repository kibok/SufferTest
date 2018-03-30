//
//  TopViewModel.swift
//  SufferTest
//
//  Created by 朴 基馥 on 2018/03/08.
//  Copyright © 2018年 Fenrir Inc. All rights reserved.
//

import UIKit

enum ProjectState: Int {
    
    case ongoing = 0
    case success = 1
    case fail = 2
    case giveup = 3
    
    init(_ value: Int) {
        switch value {
        case 0:
            self = .ongoing
        case 1:
            self = .success
        case 2:
            self = .fail
        case 3:
            self = .giveup
        default:
            self = .ongoing
        }
    }
    
}

struct TopViewModel {
    
    enum ResultState {
        
        case over
        
        case full
        
        case soso
        
        case warning
        
        case end
        
        init(result: Int) {
            switch result {
            case (101...):
                self = .over
            case (80...100):
                self = .full
            case (40...79):
                self = .soso
            case (0...39):
                self = .warning
            case (...0):
                self = .end
            default:
                self = .full
            }
        }
        
        var backgroundColor: UIColor {
            switch self {
            case .over:
                return UIColor.white
            case  .full:
                return UIColor.green
            case .soso:
                return UIColor.blue
            case .warning:
                return UIColor.red
            case .end:
                return UIColor.black
            }
        }
    }
    
    let state: ProjectState
    let startDate: Date
    let endDate: Date
    let period: Int
    let today: Int
    let startAmount: Int
    let resultAmount: Int
    let details: [Detail]
    let resultState: ResultState
    
    init(project: Project) {
        self.state = project.projectState
        self.startDate = project.startDate
        self.endDate = project.endDate
        self.startAmount = project.startAmount
        self.details = project.details
        self.resultAmount = self.startAmount - self.details.map { $0.amount }.reduce(0, +)
        self.today = Calendar.current.dateComponents([.day], from: startDate, to: Date()).day! + 1
        self.period = Calendar.current.dateComponents([.day], from: startDate, to: endDate).day!
        
        let result: Double = Double(self.resultAmount) / Double(self.startAmount) * 100
        
        self.resultState = ResultState(result: Int(result))
    }
    
    var isDday: Bool {
        return self.period == self.today
    }
    
}
