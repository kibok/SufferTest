//
//  Models.swift
//  SufferTest
//
//  Created by Kibok on 2018. 3. 15..
//  Copyright © 2018년 Fenrir Inc. All rights reserved.
//

import UIKit
import Firebase

/// 상세
///
/// - title: 수입, 지출 이름
/// - amount: 금액(+,-)
struct Detail {
    
    let inputDate: Date
    let title: String
    let amount: Int
    
    init(_ json: JSON) {
        self.inputDate = json["inputDate"] as! Date
        self.title = json["title"] as! String
        self.amount = json["amount"] as! Int
    }
    
    init(inputDate: Date, title: String, amount: Int) {
        self.inputDate = inputDate
        self.title = title
        self.amount = amount
    }
}

/// 프로젝트
///
/// - projectState: 프로젝트 상태
/// - startDate: 시작날짜
/// - endDate: 끝나는날짜
/// - startAmount: 시작금액
/// - resultAmount: 결과금액
/// - details: 상세
struct Project {
    
    let projectState: ProjectState
    let startDate: Date
    let endDate: Date
    let startAmount: Int
//    var resultAmount: Int
    var details: [Detail]
    
    init(_ json: JSON) {
        self.projectState = ProjectState(json["projectState"] as! Int)
        self.startDate = json["startDate"] as! Date
        self.endDate = json["endDate"] as! Date
        self.startAmount = json["startAmount"] as! Int
//        self.resultAmount = json["resultAmount"] as! Int
        let details = json["details"] as! [JSON]
        self.details = details.map { Detail($0) }
    }
    
    init(state: ProjectState, endDate: Date, startAmout: Int) {
        self.projectState = state
        self.startDate = Date()
        self.endDate = endDate
        self.details = []
        self.startAmount = startAmout
//        self.resultAmount = self.startAmount - self.details.map { $0.amount }.reduce(0, +)
    }
    
}

/// 유저이력
///
/// - ongoingProject: 진행중인 구매이력
/// - projectHistory: 프로젝트 이력
struct UserHistory {
    
    var ongoingProject: Project?
    var projectHistory: [Project] = []
    
    init(_ json: JSON) {
        self.ongoingProject = Project(json["ongoingProject"] as! JSON)
        let projects = json["projectHistory"] as! [JSON]
        self.projectHistory = projects.map { Project($0) }
    }
}

