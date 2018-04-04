//
//  Project.swift
//  SufferTest
//
//  Created by Kibok on 2018. 3. 15..
//  Copyright © 2018년 Fenrir Inc. All rights reserved.
//

import Foundation

class DataManager {
    
    // Singleton
    static let shared = DataManager()
    
    var ongoingProject: Project? = nil
    var projectHistory: [Project] = []
    
    private init() { }
    
    static func updateAll(response: UserHistory) {
        shared.ongoingProject = response.ongoingProject
        shared.projectHistory = response.projectHistory
    }
    
    static func updateongoing(project: Project) {
        shared.ongoingProject = project
    }
    
    static func addDetail(detail: Detail) {
        shared.ongoingProject?.details.append(detail)
    }
    
    static func updateHistory(project: Project) {
        shared.projectHistory.append(project)
    }
    
    static func closingHistory(state: ProjectState = .success) {
        if var project = shared.ongoingProject {
            project.projectState = state
            updateHistory(project: project)
            shared.ongoingProject = nil
        }
    }
    
    static func clear() {
        shared.ongoingProject = nil
        shared.projectHistory = []
    }
    
}
