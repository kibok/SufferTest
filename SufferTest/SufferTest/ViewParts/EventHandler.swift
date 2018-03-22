//
//  EventHandler.swift
//  SufferTest
//
//  Created by 朴 基馥 on 2018/03/22.
//  Copyright © 2018年 Fenrir Inc. All rights reserved.
//

import UIKit

class EventHandler {
    
    enum Event: Int {
        
        case over
        
        case full
        
        case soso
        
        case warning
        
        case danger
        
        var backgroundColor: UIColor {
            switch self {
            case .over:
                return UIColor.white
            case  .full:
                return UIColor.green
            case .soso:
                return UIColor.blue
            case .warning:
                return UIColor.orange
            case .danger:
                return UIColor.red
            }
        }
    }
    
    
    private var event: Event = .full
    
    init(start: Int, result: Int) {
        self.event = self.checkAmount(start: start, result: start)
        self.setAnimation()
    }
    
    private func checkAmount(start: Int, result: Int) -> Event {
        return .soso
    }
    
    func setEvent(start: Int, result: Int) {
        self.event = self.checkAmount(start: start, result: start)
        self.setAnimation()
    }
    
    func setAnimation() {
        // run animation with Lottie
    }
    
}
