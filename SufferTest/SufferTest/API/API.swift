//
//  API.swift
//  SufferTest
//
//  Created by Kibok on 2018. 3. 15..
//  Copyright © 2018년 Fenrir Inc. All rights reserved.
//

import UIKit
import Firebase

typealias Parameters = [String: Any]

struct ProjectAPI {
    
    static func makeProjectParameters() -> Parameters? {
        guard let project = DataManager.shared.ongoingProject else {
            return nil
        }
        let details: [Parameters] = project.details.flatMap { [ "inputDate": $0.inputDate, "title": $0.title, "amount": $0.amount ] }
        return [
            "projectState": project.projectState.rawValue,
            "startDate": project.startDate,
            "endDate": project.endDate,
            "startAmount": project.startAmount,
//            "resultAmount": project.resultAmount,
            "details": details
        ]
    }
    
    static func makeHistoryParameters() -> [Parameters] {
        return DataManager.shared.projectHistory.map { project in
            let details: [Parameters] = project.details.flatMap { [ "inputDate": $0.inputDate, "title": $0.title, "amount": $0.amount ] }
            return [
                "projectState": project.projectState.rawValue,
                "startDate": project.startDate,
                "endDate": project.endDate,
                "startAmount": project.startAmount,
//                "resultAmount": project.resultAmount,
                "details": details
            ]
        }
    }
    
    static func makeUserHistoryParameters() -> Parameters {
        return [
            "ongoingProject": self.makeProjectParameters() ?? NSNull(),
            "projectHistory": self.makeHistoryParameters()
        ]
    }
    
}


